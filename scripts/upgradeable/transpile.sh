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
# -q: partial transpilation (peer mode) so stateless files (interfaces/libraries) are left untranspiled
#     and imported from a peer package instead. The peer path is path.join('@openzeppelin/community-contracts',
#     <file path>): OUR OWN stateless files (contracts/utils/Masks.sol) correctly become
#     @openzeppelin/community-contracts/contracts/utils/Masks.sol (reused from the published non-upgradeable
#     package, like contracts-upgradeable reuses @openzeppelin/contracts). The side effect is that vanilla /
#     axelar / wormhole stateless files get DOUBLE-prefixed
#     (@openzeppelin/community-contracts/@openzeppelin/contracts/...); the post-processing below strips that.
npx @openzeppelin/upgrade-safe-transpiler -D \
  -b "$build_info" \
  -i '@openzeppelin/contracts/proxy/utils/Initializable.sol' \
  -x 'contracts-exposed/**/*' \
  -x '@openzeppelin/contracts/proxy/**/*Proxy*.sol' \
  -x '@openzeppelin/contracts/proxy/beacon/UpgradeableBeacon.sol' \
  -x '@openzeppelin/contracts/mocks/**/*Proxy*.sol' \
  -x 'contracts/proxy/**/*' \
  -N '@openzeppelin/contracts-upgradeable/**/*' \
  -N '@openzeppelin/contracts/**/*' \
  -n \
  -N 'contracts/mocks/**/*' \
  -q '@openzeppelin/community-contracts'

# Fix up dependency imports (see the -q note above). Two passes per file:
#   1. Strip the "@openzeppelin/community-contracts/" prefix the peer step wrongly prepended to third-party
#      stateless files. The (?!contracts/) lookahead protects OUR OWN files (which legitimately live under
#      @openzeppelin/community-contracts/contracts/...), so only vanilla/axelar/wormhole imports are un-prefixed.
#   2. Redirect the regenerated vanilla *Upgradeable contracts (transpiled here) to the published
#      @openzeppelin/contracts-upgradeable. The (?:\.\./)* absorbs the relative form the generated
#      mocks/WithInit.sol uses ("../../@openzeppelin/contracts/...Upgradeable.sol").
find contracts -name '*.sol' -exec perl -pi -e '
  s{"\@openzeppelin/community-contracts/(?!contracts/)([^"]*)"}{"$1"}g;
  s{"(?:\.\./)*\@openzeppelin/contracts/([^"]*Upgradeable\.sol)"}{"\@openzeppelin/contracts-upgradeable/$1"}g;
' {} +

# The transpiler emits the regenerated dependency contracts at the repo root (./@openzeppelin/contracts,
# and empty ./@axelar-network, ./wormhole-solidity-sdk for the stateless deps). We reuse the published
# @openzeppelin/contracts-upgradeable via the redirect above and never ship these, so drop them — otherwise
# they linger outside contracts/ and can shadow dependency resolution on local compiles.
rm -rf ./@openzeppelin ./@axelar-network ./wormhole-solidity-sdk

sed -i'' -e 's/viaIR: false/viaIR: true/g' hardhat.config.js

# delete compilation artifacts of vanilla code
npm run clean
