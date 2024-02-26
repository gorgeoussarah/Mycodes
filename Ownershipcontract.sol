// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// Specifies compatibility with Solidity compiler versions up to 0.9.0.

contract OwnershipControl {
    // Declares a smart contract for ownership control.

    address public owner;
    // Declares a publicly accessible variable 'owner' representing the contract owner.

    constructor() {
        // Constructor function sets the deployer's address as the initial owner.
        owner = msg.sender;
    }

    modifier onlyOwner() {
        // Modifier restricts access to functions to the owner only.
        require(msg.sender == owner, "You are not the owner.");
        _; // Indicates where the modified function code should be inserted.
    }

    function setOwner(address _newOwner) public onlyOwner {
        // Function to change ownership, only callable by the current owner.
        require(_newOwner != address(0), 'Invalid address');
        owner = _newOwner; // Sets the new owner.
    }

    function onlyOwnerCanCall() public onlyOwner {
        // Example function that can only be called by the owner.
    }

    function anyoneCanCall() public {
        // Example function that can be called by anyone.
    }
}
/*
Explanation:

1. contract OwnershipControl {: Declares a smart contract for ownership control.
2. address public owner;: Declares a publicly accessible variable 'owner' representing the contract owner.
3. constructor() { owner = msg.sender; }: Constructor function sets the deployer's address as the initial owner.
modifier onlyOwner() { ... }: Modifier restricts access to functions to the owner only.
4. function setOwner(address _newOwner) public onlyOwner { ... }: Function to change ownership, only callable by the current owner.
5. function onlyOwnerCanCall() public onlyOwner { ... }: Example function that can only be called by the owner.
6. function anyoneCanCall() public { ... }: Example function that can be called by anyone.

*/

