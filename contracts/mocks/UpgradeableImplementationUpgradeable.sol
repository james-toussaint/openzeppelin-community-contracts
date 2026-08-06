// SPDX-License-Identifier: MIT

pragma solidity ^0.8.27;

import {ERC1967Utils} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Utils.sol";
import {Initializable} from "@openzeppelin/contracts/proxy/utils/Initializable.sol";

// Note using UUPSUpgradeable here will be too restrictive
// - when upgrading an HydridProxy from beacon mode to UUPS mode, the `_checkProxy` check fails (implementation slot doesn't contain "self")
// - when upgrading an HydridProxy from UUPS mode to beacon mode, the IERC1822Proxiable check fails (beacon doesn't implement it)
// So we manually implement `upgradeToAndCall` without any checks
contract UpgradeableImplementationMockUpgradeable is Initializable {
    address private __self;
    uint256 public version;

    error UnexpectedCall(address, uint256, bytes);

    function __UpgradeableImplementationMock_init(uint256 _version) internal onlyInitializing {
        __UpgradeableImplementationMock_init_unchained(_version);
    }

    function __UpgradeableImplementationMock_init_unchained(uint256 _version) internal onlyInitializing {
        __self = address(this);
        version = _version;
    }

    function upgradeToAndCall(address newImplementation, bytes memory data) public payable virtual {
        ERC1967Utils.upgradeToAndCall(newImplementation, data);
    }

    receive() external payable {
        revert UnexpectedCall(msg.sender, msg.value, "0x");
    }

    fallback() external payable {
        revert UnexpectedCall(msg.sender, msg.value, msg.data);
    }
}
