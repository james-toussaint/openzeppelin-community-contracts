// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {IERC7943Fungible} from "../../../interfaces/IERC7943.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC165, IERC165} from "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import {ERC20Forcible} from "./ERC20Forcible.sol";
import {ERC20Seizable} from "./ERC20Seizable.sol";
import {ERC20Freezable} from "./ERC20Freezable.sol";
import {ERC20Restricted} from "./ERC20Restricted.sol";

/**
 * @dev Extension of {ERC20} according to https://eips.ethereum.org/EIPS/eip-7943[EIP-7943].
 *
 * Combines standard ERC-20 functionality with RWA-specific features like account restrictions,
 * asset freezing, and forced asset transfers. This contract doesn't expose minting or burning
 * capabilities; if implemented in derived contracts as needed, they must include 7943-specific
 * logic.
 *
 * NOTE: {canSend} and {canReceive} default to {ERC20Restricted-canTransact}. Overriding them to
 * be more permissive than `canTransact` requires overriding `canTransact` (or the restriction
 * setup) accordingly, otherwise {ERC20Restricted-_update} will still block the transfer.
 */
abstract contract ERC20uRWA is ERC20, ERC165, ERC20Seizable, ERC20Freezable, ERC20Restricted, IERC7943Fungible {
    /// @inheritdoc ERC165
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC165, IERC165) returns (bool) {
        return interfaceId == type(IERC7943Fungible).interfaceId || super.supportsInterface(interfaceId);
    }

    /**
     * @dev See {IERC7943Fungible-canSend}. Returns whether `account` is allowed to send tokens. Defaults to {ERC20Restricted-canTransact}.
     *
     * Override to implement sender-specific restrictions distinct from {canReceive}.
     */
    function canSend(address account) public view virtual returns (bool) {
        return canTransact(account);
    }

    /**
     * @dev See {IERC7943Fungible-canReceive}. Returns whether `account` is allowed to receive tokens. Defaults to {ERC20Restricted-canTransact}.
     *
     * Override to implement recipient-specific restrictions distinct from {canSend}.
     */
    function canReceive(address account) public view virtual returns (bool) {
        return canTransact(account);
    }

    /**
     * @dev See {IERC7943Fungible-canTransfer}.
     *
     * Returns false when the transfer is prevented by a permissioned rule: an `amount` exceeding
     * the unfrozen balance (only while covered by the current balance), or {canSend} / {canReceive}
     * restrictions. Plain balance insufficiency (`amount > balanceOf(from)`) does not return false
     * here, as those validations belong to the base ERC-20 standard per EIP-7943.
     *
     * CAUTION: This function is only meant for external use. Overriding it will not apply the new
     * checks to the internal {_update} function, which enforces {canSend}, {canReceive} and the
     * unfrozen balance directly. Consider overriding {_update} accordingly to keep both in sync.
     */
    function canTransfer(address from, address to, uint256 amount) external view virtual returns (bool) {
        return canSend(from) && canReceive(to) && (amount > balanceOf(from) || amount <= available(from));
    }

    /// @inheritdoc IERC7943Fungible
    function getFrozenTokens(address account) public view virtual returns (uint256 amount) {
        return frozen(account);
    }

    /**
     * @dev See {IERC7943Fungible-setFrozenTokens}. Always returns true if successful. Reverts otherwise.
     *
     * NOTE: The `amount` is allowed to exceed the current balance to support future balances withholding,
     * as required by the EIP-7943 spec.
     */
    function setFrozenTokens(address account, uint256 amount) public virtual returns (bool result) {
        _checkFreezer(account, amount);
        _setFrozen(account, amount);
        return true;
    }

    /**
     * @dev See {IERC7943Fungible-forcedTransfer}. Always returns true if successful. Reverts otherwise.
     *
     * Bypasses the {canSend} and {ERC20Restricted} checks for the `from` address and transfers the
     * amount from `from` to `to`. The recipient is still required to pass the {canReceive} check,
     * as recommended by EIP-7943. Frozen tokens are unfrozen first, as required by EIP-7943, via
     * {ERC20Freezable} (emitting {IERC7943Fungible-Frozen}).
     *
     * CAUTION: The sender-side and recipient-side checks are suppressed for the duration of the
     * internal {_update} call. If an override of {_update} performs external calls, a reentering
     * transfer will skip those checks as well. Consider adding reentrancy protection when
     * extending {_update} with external calls.
     */
    function forcedTransfer(address from, address to, uint256 amount) public virtual returns (bool result) {
        _checkEnforcer(from, to, amount);
        require(canReceive(to), ERC7943CannotReceive(to));
        _seize(from, to, amount);
        return true;
    }

    /**
     * @dev See {ERC20-_update}. Enforces the {canSend} and {canReceive} checks on top of the
     * inherited freezing ({ERC20Freezable}) and restriction ({ERC20Restricted}) checks, so that
     * public transfers cannot succeed in cases where {canTransfer} would return false. Skipped
     * during a {forcedTransfer}.
     */
    function _update(
        address from,
        address to,
        uint256 amount
    ) internal virtual override(ERC20, ERC20Freezable, ERC20Restricted) {
        if (!_isForcedTransfer()) {
            if (from != address(0)) require(canSend(from), ERC20UserRestricted(from)); // Not minting
            if (to != address(0)) require(canReceive(to), ERC20UserRestricted(to)); // Not burning
        }
        super._update(from, to, amount);
    }

    /// @inheritdoc ERC20Forcible
    function _isForcedTransfer() internal view virtual override(ERC20Forcible, ERC20Seizable) returns (bool) {
        return super._isForcedTransfer();
    }

    /**
     * @dev Internal function to check if the `enforcer` is allowed to forcibly transfer the `amount` of `tokens`.
     *
     * Example usage with {AccessControl-onlyRole}:
     *
     * ```solidity
     * function _checkEnforcer(address from, address to, uint256 amount) internal view override onlyRole(ENFORCER_ROLE) {}
     * ```
     */
    function _checkEnforcer(address from, address to, uint256 amount) internal view virtual;

    /**
     * @dev Internal function to check if the `freezer` is allowed to freeze the `amount` of `tokens`.
     *
     * Example usage with {AccessControl-onlyRole}:
     *
     * ```solidity
     * function _checkFreezer(address account, uint256 amount) internal view override onlyRole(FREEZER_ROLE) {}
     * ```
     */
    function _checkFreezer(address account, uint256 amount) internal view virtual;
}
