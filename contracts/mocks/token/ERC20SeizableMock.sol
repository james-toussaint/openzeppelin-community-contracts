// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import {ERC20Seizable} from "../../token/ERC20/extensions/ERC20Seizable.sol";

/**
 * @dev {ERC20Seizable} with a stand-in {_update} restriction that honors {ERC20Forcible}, so tests
 * can verify a seizure ({_seize}) bypasses `_update` logic guarded by {_isForcedTransfer} while a
 * normal transfer does not. Self-contained: it does not rely on {ERC20Freezable} / {ERC20Restricted}.
 */
abstract contract ERC20SeizableMock is ERC20Seizable {
    /// @dev A normal (non-forced) transfer is rejected by this stand-in restriction.
    error ERC20SeizableMockNotForced();

    function _update(address from, address to, uint256 value) internal virtual override {
        if (from != address(0) && !_isForcedTransfer()) revert ERC20SeizableMockNotForced(); // not minting
        super._update(from, to, value);
    }
}
