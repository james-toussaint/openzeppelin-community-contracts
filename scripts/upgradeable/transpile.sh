#!/usr/bin/env bash

set -euo pipefail -x

VERSION="$(jq -r .version package.json)"
DIRNAME="$(dirname -- "${BASH_SOURCE[0]}")"

bash "$DIRNAME/patch-apply.sh"

rm -f \
  contracts/crosschain/axelar/AxelarGatewayAdapter.sol \
  contracts/mocks/account/AccountZKEmailMock.sol \
  contracts/mocks/utils/cryptography/ZKEmailGroth16VerifierMock.sol \
  contracts/utils/cryptography/ZKEmailUtils.sol \
  contracts/utils/cryptography/signers/SignerZKEmail.sol \
  contracts/utils/cryptography/verifiers/ERC7913ZKEmailVerifier.sol

sed -i'' -e "s/<package-version>/$VERSION/g" "package.json"
git add package.json

npm run clean
npm run compile

build_info=($(jq -r '.input.sources | keys | if any(test("^contracts/mocks/.*\\bunreachable\\b")) then empty else input_filename end' artifacts/build-info/*))
build_info_num=${#build_info[@]}

if [ $build_info_num -ne 1 ]; then
  echo "found $build_info_num relevant build info files but expected just 1"
  exit 1
fi

# -D: delete original and excluded files
# -b: use this build info file
# -x: exclude contracts from transpilation entirely
# -N: exclude from namespaces transformation
# -n: use namespaces
# -q: partial transpilation (peer mode) so stateless dependencies (interfaces/libraries) are left
#     untranspiled. Value is '.' so the peer path-join is a no-op (path.join('.', x) === x) and their
#     imports keep their original scoped paths (e.g. @openzeppelin/contracts/*, @axelar-network/*).
#     Using a package prefix like '@openzeppelin/' here would double-prefix them (@openzeppelin/@axelar-...).
npx @openzeppelin/upgrade-safe-transpiler -D \
  -b "$build_info" \
  -i '@openzeppelin/contracts/proxy/utils/Initializable.sol' \
  -x 'contracts-exposed/**/*' \
  -N '@openzeppelin/contracts-upgradeable/**/*' \
  -N '@openzeppelin/contracts/**/*' \
  -n \
  -N 'contracts/mocks/**/*' \
  -q '.'

# The `(?:\.\./)*` absorbs relative-path forms too: the transpiler-generated mocks/WithInit.sol imports
# the regenerated files as "../../@openzeppelin/contracts/...Upgradeable.sol", which must also be redirected
# to the package path (not just the bare "@openzeppelin/contracts/..." form used by our own contracts).
find contracts -name '*.sol' -exec perl -pi -e \
  's{"(?:\.\./)*\@openzeppelin/contracts/([^"]*Upgradeable\.sol)"}{"\@openzeppelin/contracts-upgradeable/$1"}g' {} +

# The transpiler emits the regenerated dependency contracts at the repo root (./@openzeppelin/contracts,
# and empty ./@axelar-network, ./wormhole-solidity-sdk for the stateless deps). We reuse the published
# @openzeppelin/contracts-upgradeable via the redirect above and never ship these, so drop them — otherwise
# they linger outside contracts/ and can shadow dependency resolution on local compiles.
rm -rf ./@openzeppelin ./@axelar-network ./wormhole-solidity-sdk

# delete compilation artifacts of vanilla code
npm run clean
