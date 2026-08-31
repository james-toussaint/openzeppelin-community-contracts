// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import {ERC20Freezable} from "../../token/ERC20/extensions/ERC20Freezable.sol";

/// @dev {ERC20Freezable} with a settable forced-transfer context, to test its forced-transfer path.
abstract contract ERC20FreezableMock is ERC20Freezable {
    bool private _forced;

    /// @dev Test helper: toggle the {ERC20Forcible} forced-transfer context.
    function setForced(bool forced) public virtual {
        _forced = forced;
    }

    function _isForcedTransfer() internal view virtual override returns (bool) {
        return _forced;
    }
}
