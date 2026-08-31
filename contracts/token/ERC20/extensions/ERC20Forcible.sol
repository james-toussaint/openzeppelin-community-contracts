// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

/**
 * @dev Shared base for {ERC20} extensions to support forced transfers.
 */
abstract contract ERC20Forcible {
    /// @dev Whether a forced transfer is currently being performed. Defaults to false.
    function _isForcedTransfer() internal view virtual returns (bool) {
        return false;
    }
}
