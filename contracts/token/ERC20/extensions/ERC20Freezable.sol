// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";
import {IERC7943Fungible} from "../../../interfaces/IERC7943.sol";
import {ERC20Forcible} from "./ERC20Forcible.sol";

/**
 * @dev Extension of {ERC20} that allows to implement a freezing
 * mechanism that can be managed by an authorized account with the
 * {_setFrozen} function.
 *
 * The freezing mechanism provides the guarantee to the contract owner
 * (e.g. a DAO or a well-configured multisig) that a specific amount
 * of tokens held by an account won't be transferable until the frozen amount
 * is reduced using {_setFrozen}.
 */
abstract contract ERC20Freezable is ERC20, ERC20Forcible {
    /// @dev Frozen amount of tokens per address.
    mapping(address account => uint256) private _frozenBalances;

    /// @dev The operation failed because the account has insufficient unfrozen balance.
    error ERC20InsufficientUnfrozenBalance(address account, uint256 needed, uint256 available);

    /// @dev Returns the frozen balance of an account.
    function frozen(address account) public view virtual returns (uint256) {
        return _frozenBalances[account];
    }

    /// @dev Returns the available (unfrozen) balance of an account. Up to {balanceOf}.
    function available(address account) public view virtual returns (uint256) {
        return Math.saturatingSub(balanceOf(account), _frozenBalances[account]);
    }

    /// @dev Internal function to set the frozen token amount for a account.
    function _setFrozen(address account, uint256 amount) internal virtual {
        _frozenBalances[account] = amount;
        emit IERC7943Fungible.Frozen(account, amount);
    }

    /**
     * @dev See {ERC20-_update}.
     *
     * NOTE: A forced transfer to self moves no tokens, so it performs no frozen balance adjustment.
     * It behaves as a regular ERC-20 self-transfer, reverting if `amount` exceeds the unfrozen balance.
     *
     * Requirements:
     *
     * * `from` must have sufficient unfrozen balance
     * OR
     * * the current update comes from a forced transfer
     */
    function _update(address from, address to, uint256 value) internal virtual override {
        if (from != address(0)) {
            if (_isForcedTransfer() && from != to) {
                // Update frozen balance if needed. Following ERC-7943 that requires the balance
                // to be unfrozen first (emitting the corresponding Frozen event via _setFrozen)
                // and then send the tokens. Skipped for self-transfers, where the balance does
                // not change and no unfreeze is warranted.
                _forcedUnfreeze(from, value);
            } else {
                _checkUnfrozen(from, value);
            }
        }
        super._update(from, to, value);
    }

    /**
     * @dev Checks if the sender has enough unfrozen tokens for a transfer.
     */
    function _checkUnfrozen(address from, uint256 value) internal view virtual {
        uint256 unfrozen = available(from);
        require(unfrozen >= value, ERC20InsufficientUnfrozenBalance(from, value, unfrozen));
    }

    /**
     * @dev Sets the frozen amount for an account during a forced transfer,
     * ensuring that the frozen balance does not exceed the post-transfer balance.
     */
    function _forcedUnfreeze(address from, uint256 value) internal virtual {
        uint256 newBalance = Math.saturatingSub(balanceOf(from), value);
        if (frozen(from) > newBalance) _setFrozen(from, newBalance);
    }

    // We don't check frozen balance for approvals since the actual transfer
    // will be checked in _update. This allows for more flexible approval patterns.
}
