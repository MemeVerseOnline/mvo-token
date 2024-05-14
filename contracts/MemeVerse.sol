// SPDX-License-Identifier: MTL
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MemeVerse  is ERC20{

    constructor ()
    ERC20("MemeVerse", "MVO") {
      _mint(msg.sender, 150000000000000000000000000000); // 150,000,000,000 MVO
    }

    /**
     * @dev Burn token from caller account
     *
     * Requirements:
     *
     * - `_amounts` amount of token to burn from caller account
     */
    function burn(uint256 _amounts) external {
        _burn(msg.sender, _amounts);
    }
    
    /**
     * @dev Do bulk transfers in one transaction..
     *
     * Requirements:
     *
     * - `_receivers` array of receivers
     * - `_amounts` array of receivers amount
     * - the caller must have a balance of total sum of `_amounts`.
     * - both array inputs length should be same.
     */
    function bulkTransfer(address[] calldata _receivers, uint256[] calldata _amounts) external {
        require(_receivers.length == _amounts.length);
        for (uint256 i = 0; i < _receivers.length; i++) {
        _transfer(msg.sender, _receivers[i], _amounts[i]);
        }
    }
}
