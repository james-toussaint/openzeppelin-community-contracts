// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import {ERC20Restricted} from "../../token/ERC20/extensions/ERC20Restricted.sol";

/// @dev {ERC20Restricted} with a settable forced-transfer context, to test its forced-transfer path.
abstract contract ERC20RestrictedMock is ERC20Restricted {
    bool private _forced;

    /// @dev Test helper: toggle the {ERC20Forcible} forced-transfer context.
    function setForced(bool forced) public virtual {
        _forced = forced;
    }

    function _isForcedTransfer() internal view virtual override returns (bool) {
        return _forced;
    }
}
