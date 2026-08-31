// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {TransientSlot} from "@openzeppelin/contracts/utils/TransientSlot.sol";
import {IERC7943Fungible} from "../../../interfaces/IERC7943.sol";
import {ERC20Forcible} from "./ERC20Forcible.sol";

/**
 * @dev Extension of {ERC20} that lets a privileged account seize tokens from an account.
 *
 * Example:
 *
 * ```solidity
 * contract MyStablecoin is ERC20Seizable, AccessControl {
 *     bytes32 public constant SEIZER_ROLE = keccak256("SEIZER_ROLE");
 *
 *     function seize(address from, address to, uint256 value) external onlyRole(SEIZER_ROLE) {
 *         _seize(from, to, value);
 *     }
 * }
 * ```
 */
abstract contract ERC20Seizable is ERC20, ERC20Forcible {
    using TransientSlot for *;

    // keccak256(abi.encode(uint256(keccak256("openzeppelin.storage.ERC20Seizable")) - 1)) & ~bytes32(uint256(0xff))
    bytes32 private constant ERC20_SEIZABLE_FORCED_SLOT =
        0x866974107a9aee3de17d07442d4b54be7484bc3c2ae52ad186bdd40ed16d9e00;

    /// @inheritdoc ERC20Forcible
    function _isForcedTransfer() internal view virtual override returns (bool) {
        return ERC20_SEIZABLE_FORCED_SLOT.asBoolean().tload();
    }

    /**
     * @dev Seizes `value` tokens from `from` and transfers them to `to`. Performs the
     * forced-transfer path declared by other extensions via {_isForcedTransfer} in {_update}.
     * Access to this function should be restricted to accounts with the appropriate role.
     *
     * NOTE: This function uses {_update} to perform the transfer, ensuring all standard ERC20
     * side effects outside {_isForcedTransfer} (such as balance updates and events) are preserved.
     *
     * Requirements:
     *
     * * `from` must have a balance of at least `value`.
     *
     * CAUTION: The forced-transfer context is active for the duration of the call.
     * If an override of {_update} performs external calls, a reentering transfer will also see
     * {_isForcedTransfer} as true and skip the checks that honor it. Consider adding reentrancy
     * protection when extending {_update} with external calls.
     */
    function _seize(address from, address to, uint256 value) internal virtual {
        ERC20_SEIZABLE_FORCED_SLOT.asBoolean().tstore(true);
        _update(from, to, value);
        ERC20_SEIZABLE_FORCED_SLOT.asBoolean().tstore(false);
        emit IERC7943Fungible.ForcedTransfer(from, to, value);
    }
}
