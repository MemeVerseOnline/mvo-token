// SPDX-License-Identifier: MTL
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MemeVerse is ERC20, Ownable{

    constructor ()
    Ownable(msg.sender)
    ERC20("MemeVerse", "MVO") {
      _mint(msg.sender, 15_000_000_000 * 10**decimals()); // 15,000,000,000 MVO
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

    /************ Presale Functions *************/

    bool public isPresalePhase1Minted;
    bool public isPresalePhase2Minted;
    bool public isPresalePhase3Minted;

    /**
     * @dev Function to mint MVO after 1st phase of presale is completed, can only be called once. 
     * MVO mint amount - 30 Billion MVO
     */
    function mint_phase1() external onlyOwner {
        require(!isPresalePhase1Minted, "Error: Already minted");
        isPresalePhase1Minted = true;
        _mint(owner(), 30_000_000_000 * 10**decimals()); // 30,000,000,000 MVO
    }

    /**
     * @dev Function to mint MVO after 2nd phase of presale is completed, can only be called once. 
     * MVO mint amount - 45 Billion MVO
     */
    function mint_phase2() external onlyOwner {
        require(!isPresalePhase2Minted, "Error: Already minted");
        isPresalePhase2Minted = true;
        _mint(owner(), 45_000_000_000 * 10**decimals()); // 45,000,000,000 MVO
    }

    /**
     * @dev Function to mint MVO after 3rd phase of presale is completed, can only be called once. 
     * MVO mint amount - depends on the amount of MVO sold
     *
     * Requirements:
     * - `_amounts` amount of token to mint
     */
    function mint_phase3(uint256 _amount) external onlyOwner {
        require(!isPresalePhase3Minted, "Error: Already minted");
        isPresalePhase3Minted = true;
        _mint(owner(), _amount);
    }
}
