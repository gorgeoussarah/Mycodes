// SPDX-License-Identifier: MIT
// Specifies the license under which the contract is released, in this case, the MIT license.
pragma solidity ^0.8.20;
// Specifies the Solidity version required by the contract.

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// Imports the ERC20 standard token implementation from the OpenZeppelin library.
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
// Imports the extension for burnable ERC20 tokens from the OpenZeppelin library.
import "@openzeppelin/contracts/access/Ownable.sol";
// Imports the Ownable contract from the OpenZeppelin library.

contract MyToken is ERC20, ERC20Burnable, Ownable {
    // Defines a contract named MyToken that inherits from ERC20, ERC20Burnable, and Ownable.

    constructor(address initialOwner)
        ERC20("THESMARTBOSS", "TSB")
        Ownable(initialOwner)
    {}
    // Constructor function that initializes the ERC20 token with a name "THESMARTBOSS" and symbol "TSB".
    // The contract is also made Ownable, with the specified initial owner passed as an argument.

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
    // Public function named mint that allows the owner to mint (create) new tokens and assign them to a specified address.
    // The onlyOwner modifier ensures that only the owner of the contract can call this function.
}
