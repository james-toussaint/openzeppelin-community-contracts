// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7 <0.9;
pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";

contract AccessControlUpgradeableWithInit is AccessControlUpgradeable {
    constructor() payable initializer {
        __AccessControl_init();
    }
}
import "@openzeppelin/contracts-upgradeable/access/manager/AccessManagedUpgradeable.sol";

contract AccessManagedUpgradeableWithInit is AccessManagedUpgradeable {
    constructor(address initialAuthority) payable initializer {
        __AccessManaged_init(initialAuthority);
    }
}
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract OwnableUpgradeableWithInit is OwnableUpgradeable {
    constructor(address initialOwner) payable initializer {
        __Ownable_init(initialOwner);
    }
}
import "@openzeppelin/contracts-upgradeable/account/extensions/draft-AccountERC7579Upgradeable.sol";

contract AccountERC7579UpgradeableWithInit is AccountERC7579Upgradeable {
    constructor() payable initializer {
        __AccountERC7579_init();
    }
}
import "@openzeppelin/contracts-upgradeable/account/extensions/draft-AccountERC7579HookedUpgradeable.sol";

contract AccountERC7579HookedUpgradeableWithInit is AccountERC7579HookedUpgradeable {
    constructor() payable initializer {
        __AccountERC7579Hooked_init();
    }
}
import "@openzeppelin/contracts-upgradeable/governance/TimelockControllerUpgradeable.sol";

contract TimelockControllerUpgradeableWithInit is TimelockControllerUpgradeable {
    constructor(uint256 minDelay, address[] memory proposers, address[] memory executors, address admin) payable initializer {
        __TimelockController_init(minDelay, proposers, executors, admin);
    }
}
import "@openzeppelin/contracts-upgradeable/mocks/account/AccountMockUpgradeable.sol";

contract AccountMockUpgradeableWithInit is AccountMockUpgradeable {
    constructor() payable initializer {
        __AccountMock_init();
    }
}
import "@openzeppelin/contracts-upgradeable/mocks/account/AccountMockUpgradeable.sol";

contract AccountECDSAMockUpgradeableWithInit is AccountECDSAMockUpgradeable {
    constructor() payable initializer {
        __AccountECDSAMock_init();
    }
}
import "@openzeppelin/contracts-upgradeable/mocks/account/AccountMockUpgradeable.sol";

contract AccountP256MockUpgradeableWithInit is AccountP256MockUpgradeable {
    constructor() payable initializer {
        __AccountP256Mock_init();
    }
}
import "@openzeppelin/contracts-upgradeable/mocks/account/AccountMockUpgradeable.sol";

contract AccountRSAMockUpgradeableWithInit is AccountRSAMockUpgradeable {
    constructor() payable initializer {
        __AccountRSAMock_init();
    }
}
import "@openzeppelin/contracts-upgradeable/mocks/account/AccountMockUpgradeable.sol";

contract AccountWebAuthnMockUpgradeableWithInit is AccountWebAuthnMockUpgradeable {
    constructor() payable initializer {
        __AccountWebAuthnMock_init();
    }
}
import "@openzeppelin/contracts-upgradeable/mocks/account/AccountMockUpgradeable.sol";

contract AccountEIP7702MockUpgradeableWithInit is AccountEIP7702MockUpgradeable {
    constructor() payable initializer {
        __AccountEIP7702Mock_init();
    }
}
import "@openzeppelin/contracts-upgradeable/mocks/account/AccountMockUpgradeable.sol";

contract AccountEIP7702WithModulesMockUpgradeableWithInit is AccountEIP7702WithModulesMockUpgradeable {
    constructor() payable initializer {
        __AccountEIP7702WithModulesMock_init();
    }
}
import "@openzeppelin/contracts-upgradeable/mocks/account/AccountMockUpgradeable.sol";

contract AccountERC7579MockUpgradeableWithInit is AccountERC7579MockUpgradeable {
    constructor(address validator, bytes memory initData) payable initializer {
        __AccountERC7579Mock_init(validator, initData);
    }
}
import "@openzeppelin/contracts-upgradeable/mocks/account/AccountMockUpgradeable.sol";

contract AccountERC7579HookedMockUpgradeableWithInit is AccountERC7579HookedMockUpgradeable {
    constructor(address validator, bytes memory initData) payable initializer {
        __AccountERC7579HookedMock_init(validator, initData);
    }
}
import "@openzeppelin/contracts-upgradeable/mocks/account/AccountMockUpgradeable.sol";

contract AccountERC7913MockUpgradeableWithInit is AccountERC7913MockUpgradeable {
    constructor() payable initializer {
        __AccountERC7913Mock_init();
    }
}
import "@openzeppelin/contracts-upgradeable/mocks/account/AccountMockUpgradeable.sol";

contract AccountMultiSignerMockUpgradeableWithInit is AccountMultiSignerMockUpgradeable {
    constructor() payable initializer {
        __AccountMultiSignerMock_init();
    }
}
import "@openzeppelin/contracts-upgradeable/mocks/account/AccountMockUpgradeable.sol";

contract AccountMultiSignerWeightedMockUpgradeableWithInit is AccountMultiSignerWeightedMockUpgradeable {
    constructor() payable initializer {
        __AccountMultiSignerWeightedMock_init();
    }
}
import "@openzeppelin/contracts-upgradeable/mocks/CallReceiverMockUpgradeable.sol";

contract CallReceiverMockUpgradeableWithInit is CallReceiverMockUpgradeable {
    constructor() payable initializer {
        __CallReceiverMock_init();
    }
}
import "@openzeppelin/contracts-upgradeable/mocks/CallReceiverMockUpgradeable.sol";

contract CallReceiverMockTrustingForwarderUpgradeableWithInit is CallReceiverMockTrustingForwarderUpgradeable {
    constructor(address trustedForwarder_) payable initializer {
        __CallReceiverMockTrustingForwarder_init(trustedForwarder_);
    }
}
import "@openzeppelin/contracts-upgradeable/mocks/ERC1271WalletMockUpgradeable.sol";

contract ERC1271WalletMockUpgradeableWithInit is ERC1271WalletMockUpgradeable {
    constructor(address originalOwner) payable initializer {
        __ERC1271WalletMock_init(originalOwner);
    }
}
import "@openzeppelin/contracts-upgradeable/mocks/ERC1271WalletMockUpgradeable.sol";

contract ERC1271MaliciousMockUpgradeableWithInit is ERC1271MaliciousMockUpgradeable {
    constructor() payable initializer {
        __ERC1271MaliciousMock_init();
    }
}
import "@openzeppelin/contracts-upgradeable/token/ERC1155/ERC1155Upgradeable.sol";

contract ERC1155UpgradeableWithInit is ERC1155Upgradeable {
    constructor(string memory uri_) payable initializer {
        __ERC1155_init(uri_);
    }
}
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";

contract ERC20UpgradeableWithInit is ERC20Upgradeable {
    constructor(string memory name_, string memory symbol_) payable initializer {
        __ERC20_init(name_, symbol_);
    }
}
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC4626Upgradeable.sol";

contract ERC4626UpgradeableWithInit is ERC4626Upgradeable {
    constructor(IERC20 asset_) payable initializer {
        __ERC4626_init(asset_);
    }
}
import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";

contract ERC721UpgradeableWithInit is ERC721Upgradeable {
    constructor(string memory name_, string memory symbol_) payable initializer {
        __ERC721_init(name_, symbol_);
    }
}
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721EnumerableUpgradeable.sol";

contract ERC721EnumerableUpgradeableWithInit is ERC721EnumerableUpgradeable {
    constructor() payable initializer {
        __ERC721Enumerable_init();
    }
}
import "@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol";

contract ContextUpgradeableWithInit is ContextUpgradeable {
    constructor() payable initializer {
        __Context_init();
    }
}
import "@openzeppelin/contracts-upgradeable/utils/cryptography/EIP712Upgradeable.sol";

contract EIP712UpgradeableWithInit is EIP712Upgradeable {
    constructor(string memory name, string memory version) payable initializer {
        __EIP712_init(name, version);
    }
}
import "@openzeppelin/contracts-upgradeable/utils/cryptography/signers/MultiSignerERC7913Upgradeable.sol";

contract MultiSignerERC7913UpgradeableWithInit is MultiSignerERC7913Upgradeable {
    constructor(bytes[] memory signers_, uint64 threshold_) payable initializer {
        __MultiSignerERC7913_init(signers_, threshold_);
    }
}
import "@openzeppelin/contracts-upgradeable/utils/cryptography/signers/MultiSignerERC7913WeightedUpgradeable.sol";

contract MultiSignerERC7913WeightedUpgradeableWithInit is MultiSignerERC7913WeightedUpgradeable {
    constructor(bytes[] memory signers_, uint64[] memory weights_, uint64 threshold_) payable initializer {
        __MultiSignerERC7913Weighted_init(signers_, weights_, threshold_);
    }
}
import "@openzeppelin/contracts-upgradeable/utils/cryptography/signers/SignerECDSAUpgradeable.sol";

contract SignerECDSAUpgradeableWithInit is SignerECDSAUpgradeable {
    constructor(address signerAddr) payable initializer {
        __SignerECDSA_init(signerAddr);
    }
}
import "@openzeppelin/contracts-upgradeable/utils/cryptography/signers/SignerERC7913Upgradeable.sol";

contract SignerERC7913UpgradeableWithInit is SignerERC7913Upgradeable {
    constructor(bytes memory signer_) payable initializer {
        __SignerERC7913_init(signer_);
    }
}
import "@openzeppelin/contracts-upgradeable/utils/cryptography/signers/SignerP256Upgradeable.sol";

contract SignerP256UpgradeableWithInit is SignerP256Upgradeable {
    constructor(bytes32 qx, bytes32 qy) payable initializer {
        __SignerP256_init(qx, qy);
    }
}
import "@openzeppelin/contracts-upgradeable/utils/cryptography/signers/SignerRSAUpgradeable.sol";

contract SignerRSAUpgradeableWithInit is SignerRSAUpgradeable {
    constructor(bytes memory e, bytes memory n) payable initializer {
        __SignerRSA_init(e, n);
    }
}
import "@openzeppelin/contracts-upgradeable/utils/cryptography/signers/SignerWebAuthnUpgradeable.sol";

contract SignerWebAuthnUpgradeableWithInit is SignerWebAuthnUpgradeable {
    constructor() payable initializer {
        __SignerWebAuthn_init();
    }
}
import "@openzeppelin/contracts-upgradeable/utils/introspection/ERC165Upgradeable.sol";

contract ERC165UpgradeableWithInit is ERC165Upgradeable {
    constructor() payable initializer {
        __ERC165_init();
    }
}
import "@openzeppelin/contracts-upgradeable/utils/NoncesUpgradeable.sol";

contract NoncesUpgradeableWithInit is NoncesUpgradeable {
    constructor() payable initializer {
        __Nonces_init();
    }
}
import "@openzeppelin/contracts-upgradeable/utils/PausableUpgradeable.sol";

contract PausableUpgradeableWithInit is PausableUpgradeable {
    constructor() payable initializer {
        __Pausable_init();
    }
}
import "../access/manager/AccessManagerLightUpgradeable.sol";

contract AccessManagerLightUpgradeableWithInit is AccessManagerLightUpgradeable {
    constructor(address admin) payable initializer {
        __AccessManagerLight_init(admin);
    }
}
import "../account/modules/ERC7579MultisigUpgradeable.sol";

contract ERC7579MultisigUpgradeableWithInit is ERC7579MultisigUpgradeable {
    constructor() payable initializer {
        __ERC7579Multisig_init();
    }
}
import "../account/modules/ERC7579MultisigConfirmationUpgradeable.sol";

contract ERC7579MultisigConfirmationUpgradeableWithInit is ERC7579MultisigConfirmationUpgradeable {
    constructor() payable initializer {
        __ERC7579MultisigConfirmation_init();
    }
}
import "../account/modules/ERC7579MultisigStorageUpgradeable.sol";

contract ERC7579MultisigStorageUpgradeableWithInit is ERC7579MultisigStorageUpgradeable {
    constructor() payable initializer {
        __ERC7579MultisigStorage_init();
    }
}
import "../account/modules/ERC7579MultisigWeightedUpgradeable.sol";

contract ERC7579MultisigWeightedUpgradeableWithInit is ERC7579MultisigWeightedUpgradeable {
    constructor() payable initializer {
        __ERC7579MultisigWeighted_init();
    }
}
import "../account/modules/ERC7579SelectorExecutorUpgradeable.sol";

contract ERC7579SelectorExecutorUpgradeableWithInit is ERC7579SelectorExecutorUpgradeable {
    constructor() payable initializer {
        __ERC7579SelectorExecutor_init();
    }
}
import "../account/modules/ERC7579SignatureUpgradeable.sol";

contract ERC7579SignatureUpgradeableWithInit is ERC7579SignatureUpgradeable {
    constructor() payable initializer {
        __ERC7579Signature_init();
    }
}
import "../crosschain/axelar/AxelarGatewayAdapterUpgradeable.sol";

contract AxelarGatewayAdapterUpgradeableWithInit is AxelarGatewayAdapterUpgradeable {
    constructor(
        IAxelarGateway gateway,
        address initialOwner
    ) payable initializer {
        __AxelarGatewayAdapter_init(gateway, initialOwner);
    }
}
import "../crosschain/ERC7786OpenBridgeUpgradeable.sol";

contract ERC7786OpenBridgeUpgradeableWithInit is ERC7786OpenBridgeUpgradeable {
    constructor(address owner_, address[] memory gateways_, uint8 threshold_) payable initializer {
        __ERC7786OpenBridge_init(owner_, gateways_, threshold_);
    }
}
import "../crosschain/wormhole/WormholeGatewayAdapterUpgradeable.sol";

contract WormholeGatewayAdapterUpgradeableWithInit is WormholeGatewayAdapterUpgradeable {
    constructor(IWormholeRelayer wormholeRelayer, uint16 wormholeChainId, address initialOwner) payable initializer {
        __WormholeGatewayAdapter_init(wormholeRelayer, wormholeChainId, initialOwner);
    }
}
import "../governance/TimelockControllerEnumerableUpgradeable.sol";

contract TimelockControllerEnumerableUpgradeableWithInit is TimelockControllerEnumerableUpgradeable {
    constructor() payable initializer {
        __TimelockControllerEnumerable_init();
    }
}
import "./account/AccountZKEmailMockUpgradeable.sol";

contract AccountZKEmailMockUpgradeableWithInit is AccountZKEmailMockUpgradeable {
    constructor(
        bytes32 accountSalt_,
        IDKIMRegistry registry_,
        IGroth16Verifier groth16Verifier_
    ) payable initializer {
        __AccountZKEmailMock_init(accountSalt_, registry_, groth16Verifier_);
    }
}
import "./account/modules/ERC7579ExecutorMocksUpgradeable.sol";

contract ERC7579ExecutorMockUpgradeableWithInit is ERC7579ExecutorMockUpgradeable {
    constructor() payable initializer {
        __ERC7579ExecutorMock_init();
    }
}
import "./account/modules/ERC7579ExecutorMocksUpgradeable.sol";

contract ERC7579DelayedExecutorMockUpgradeableWithInit is ERC7579DelayedExecutorMockUpgradeable {
    constructor() payable initializer {
        __ERC7579DelayedExecutorMock_init();
    }
}
import "./account/modules/ERC7579FallbackHandlerMockUpgradeable.sol";

contract ERC7579FallbackHandlerMockUpgradeableWithInit is ERC7579FallbackHandlerMockUpgradeable {
    constructor() payable initializer {
        __ERC7579FallbackHandlerMock_init();
    }
}
import "./account/modules/ERC7579HookMockUpgradeable.sol";

contract ERC7579HookMockUpgradeableWithInit is ERC7579HookMockUpgradeable {
    constructor() payable initializer {
        __ERC7579HookMock_init();
    }
}
import "./account/modules/ERC7579ModuleMockUpgradeable.sol";

contract ERC7579ModuleMockUpgradeableWithInit is ERC7579ModuleMockUpgradeable {
    constructor(uint256 moduleTypeId) payable initializer {
        __ERC7579ModuleMock_init(moduleTypeId);
    }
}
import "./account/modules/ERC7579MultisigMocksUpgradeable.sol";

contract ERC7579MultisigExecutorMockUpgradeableWithInit is ERC7579MultisigExecutorMockUpgradeable {
    constructor() payable initializer {
        __ERC7579MultisigExecutorMock_init();
    }
}
import "./account/modules/ERC7579MultisigMocksUpgradeable.sol";

contract ERC7579MultisigWeightedExecutorMockUpgradeableWithInit is ERC7579MultisigWeightedExecutorMockUpgradeable {
    constructor() payable initializer {
        __ERC7579MultisigWeightedExecutorMock_init();
    }
}
import "./account/modules/ERC7579MultisigMocksUpgradeable.sol";

contract ERC7579MultisigConfirmationExecutorMockUpgradeableWithInit is ERC7579MultisigConfirmationExecutorMockUpgradeable {
    constructor() payable initializer {
        __ERC7579MultisigConfirmationExecutorMock_init();
    }
}
import "./account/modules/ERC7579MultisigMocksUpgradeable.sol";

contract ERC7579MultisigStorageExecutorMockUpgradeableWithInit is ERC7579MultisigStorageExecutorMockUpgradeable {
    constructor() payable initializer {
        __ERC7579MultisigStorageExecutorMock_init();
    }
}
import "./crosschain/axelar/AxelarGatewayMockUpgradeable.sol";

contract AxelarGatewayMockUpgradeableWithInit is AxelarGatewayMockUpgradeable {
    constructor() payable initializer {
        __AxelarGatewayMock_init();
    }
}
import "./crosschain/ERC7786GatewayMockUpgradeable.sol";

contract ERC7786GatewayMockUpgradeableWithInit is ERC7786GatewayMockUpgradeable {
    constructor() payable initializer {
        __ERC7786GatewayMock_init();
    }
}
import "./crosschain/ERC7786RecipientInvalidMockUpgradeable.sol";

contract ERC7786RecipientInvalidMockUpgradeableWithInit is ERC7786RecipientInvalidMockUpgradeable {
    constructor() payable initializer {
        __ERC7786RecipientInvalidMock_init();
    }
}
import "./crosschain/ERC7786RecipientMockUpgradeable.sol";

contract ERC7786RecipientMockUpgradeableWithInit is ERC7786RecipientMockUpgradeable {
    constructor(address gateway_) payable initializer {
        __ERC7786RecipientMock_init(gateway_);
    }
}
import "./crosschain/ERC7786RecipientRevertMockUpgradeable.sol";

contract ERC7786RecipientRevertMockUpgradeableWithInit is ERC7786RecipientRevertMockUpgradeable {
    constructor() payable initializer {
        __ERC7786RecipientRevertMock_init();
    }
}
import "./crosschain/wormhole/WormholeRelayerMockUpgradeable.sol";

contract WormholeRelayerMockUpgradeableWithInit is WormholeRelayerMockUpgradeable {
    constructor(uint16 localChainId) payable initializer {
        __WormholeRelayerMock_init(localChainId);
    }
}
import "./docs/account/modules/MyERC7579SocialRecoveryUpgradeable.sol";

contract MyERC7579SocialRecoveryUpgradeableWithInit is MyERC7579SocialRecoveryUpgradeable {
    constructor() payable initializer {
        __MyERC7579SocialRecovery_init();
    }
}
import "./docs/crosschain/MyERC7786GatewaySourceUpgradeable.sol";

contract MyERC7786GatewaySourceUpgradeableWithInit is MyERC7786GatewaySourceUpgradeable {
    constructor() payable initializer {
        __MyERC7786GatewaySource_init();
    }
}
import "./docs/MyStablecoinAllowlistUpgradeable.sol";

contract MyStablecoinAllowlistUpgradeableWithInit is MyStablecoinAllowlistUpgradeable {
    constructor(address initialAuthority) payable initializer {
        __MyStablecoinAllowlist_init(initialAuthority);
    }
}
import "./docs/utils/cryptography/ERC7739SignerECDSAUpgradeable.sol";

contract ERC7739ECDSAUpgradeableWithInit is ERC7739ECDSAUpgradeable {
    constructor(address signerAddr) payable initializer {
        __ERC7739ECDSA_init(signerAddr);
    }
}
import "./docs/utils/cryptography/MyContractDomainUpgradeable.sol";

contract MyContractDomainUpgradeableWithInit is MyContractDomainUpgradeable {
    constructor() payable initializer {
        __MyContractDomain_init();
    }
}
import "./ERC7913VerifierMockUpgradeable.sol";

contract ERC7913VerifierMockUpgradeableWithInit is ERC7913VerifierMockUpgradeable {
    constructor() payable initializer {
        __ERC7913VerifierMock_init();
    }
}
import "./token/ERC20CollateralMockUpgradeable.sol";

contract ERC20CollateralMockUpgradeableWithInit is ERC20CollateralMockUpgradeable {
    constructor(
        uint48 liveness_,
        string memory name_,
        string memory symbol_
    ) payable initializer {
        __ERC20CollateralMock_init(liveness_, name_, symbol_);
    }
}
import "./token/ERC20CustodianMockUpgradeable.sol";

contract ERC20CustodianMockUpgradeableWithInit is ERC20CustodianMockUpgradeable {
    constructor(address custodian, string memory name_, string memory symbol_) payable initializer {
        __ERC20CustodianMock_init(custodian, name_, symbol_);
    }
}
import "./token/ERC20uRWAMockUpgradeable.sol";

contract ERC20uRWAMockUpgradeableWithInit is ERC20uRWAMockUpgradeable {
    constructor(address freezer, address enforcer) payable initializer {
        __ERC20uRWAMock_init(freezer, enforcer);
    }
}
import "./token/ERC7540AdminMockUpgradeable.sol";

contract ERC7540AdminMockUpgradeableWithInit is ERC7540AdminMockUpgradeable {
    constructor(address tmpShareHolder) payable initializer {
        __ERC7540AdminMock_init(tmpShareHolder);
    }
}
import "./token/ERC7540DelayMockUpgradeable.sol";

contract ERC7540DelayMockUpgradeableWithInit is ERC7540DelayMockUpgradeable {
    constructor() payable initializer {
        __ERC7540DelayMock_init();
    }
}
import "./token/ERC7540DelayMockUpgradeable.sol";

contract ERC7540DelayShareOriginMockUpgradeableWithInit is ERC7540DelayShareOriginMockUpgradeable {
    constructor() payable initializer {
        __ERC7540DelayShareOriginMock_init();
    }
}
import "./token/ERC7540DelayMockUpgradeable.sol";

contract ERC7540DelayShareDestinationMockUpgradeableWithInit is ERC7540DelayShareDestinationMockUpgradeable {
    constructor() payable initializer {
        __ERC7540DelayShareDestinationMock_init();
    }
}
import "./token/ERC7540SyncDepositMockUpgradeable.sol";

contract ERC7540SyncDepositMockUpgradeableWithInit is ERC7540SyncDepositMockUpgradeable {
    constructor() payable initializer {
        __ERC7540SyncDepositMock_init();
    }
}
import "./token/ERC7540SyncMockUpgradeable.sol";

contract ERC7540SyncMockUpgradeableWithInit is ERC7540SyncMockUpgradeable {
    constructor() payable initializer {
        __ERC7540SyncMock_init();
    }
}
import "./token/ERC7540SyncRedeemMockUpgradeable.sol";

contract ERC7540SyncRedeemMockUpgradeableWithInit is ERC7540SyncRedeemMockUpgradeable {
    constructor() payable initializer {
        __ERC7540SyncRedeemMock_init();
    }
}
import "./UpgradeableImplementationUpgradeable.sol";

contract UpgradeableImplementationMockUpgradeableWithInit is UpgradeableImplementationMockUpgradeable {
    constructor(uint256 _version) payable initializer {
        __UpgradeableImplementationMock_init(_version);
    }
}
import "./utils/cryptography/ZKEmailGroth16VerifierMockUpgradeable.sol";

contract ZKEmailGroth16VerifierMockUpgradeableWithInit is ZKEmailGroth16VerifierMockUpgradeable {
    constructor() payable initializer {
        __ZKEmailGroth16VerifierMock_init();
    }
}
import "../token/ERC20/extensions/ERC20AllowlistUpgradeable.sol";

contract ERC20AllowlistUpgradeableWithInit is ERC20AllowlistUpgradeable {
    constructor() payable initializer {
        __ERC20Allowlist_init();
    }
}
import "../token/ERC20/extensions/ERC20BlocklistUpgradeable.sol";

contract ERC20BlocklistUpgradeableWithInit is ERC20BlocklistUpgradeable {
    constructor() payable initializer {
        __ERC20Blocklist_init();
    }
}
import "../token/ERC20/extensions/ERC20FreezableUpgradeable.sol";

contract ERC20FreezableUpgradeableWithInit is ERC20FreezableUpgradeable {
    constructor() payable initializer {
        __ERC20Freezable_init();
    }
}
import "../token/ERC20/extensions/ERC20RestrictedUpgradeable.sol";

contract ERC20RestrictedUpgradeableWithInit is ERC20RestrictedUpgradeable {
    constructor() payable initializer {
        __ERC20Restricted_init();
    }
}
import "../token/ERC20/extensions/ERC4626FeesUpgradeable.sol";

contract ERC4626FeesUpgradeableWithInit is ERC4626FeesUpgradeable {
    constructor() payable initializer {
        __ERC4626Fees_init();
    }
}

import "../utils/cryptography/signers/SignerZKEmailUpgradeable.sol";

contract SignerZKEmailUpgradeableWithInit is SignerZKEmailUpgradeable {
    constructor() payable initializer {
        __SignerZKEmail_init();
    }
}
import "../utils/cryptography/verifiers/ERC7913ZKEmailVerifierUpgradeable.sol";

contract ERC7913ZKEmailVerifierUpgradeableWithInit is ERC7913ZKEmailVerifierUpgradeable {
    constructor() payable initializer {
        __ERC7913ZKEmailVerifier_init();
    }
}
