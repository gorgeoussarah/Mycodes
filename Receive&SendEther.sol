// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Contract to demonstrate receiving Ether and checking the contract's balance.

contract RECEIVEETHER {

    // External receive function to accept Ether transfers
    receive() external payable { }

    // Function to retrieve the current balance of the contract
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

// Contract to demonstrate different ways of sending Ether to another address.

contract sendether {

    // External receive function to accept Ether transfers
    receive() external payable { }

    // Function to send Ether to another address using the transfer method
    function sendViaTransfer(address payable to, uint amount) public payable {
        to.transfer(amount);
    }

    // Function to send Ether to another address using the send method
    function sendViaSend(address payable _to, uint amount) public payable {
        // SEND returns a boolean value indicating success or failure.
        // This function is not recommended for sending Ether.
        bool sent = _to.send(amount);
        require(sent, "FAILED TO SEND ETHER");
    }

    // Function to send Ether to another address using the call method
    function sendViaCall(address payable _to, uint amount) public payable {
        // CALL returns a boolean value indicating success or failure.
        // This is the recommended method to use.
        // You can always remove the bytes memory data; it's not compulsory, just make sure you add the comma.
        (bool sent,) = _to.call{value: amount}("");
        require(sent, "FAILED TO SEND ETHER");
    }
}
/*
Explanation:

RECEIVEETHER Contract:

1. Declares a contract named RECEIVEETHER.
2. Implements an external receive function to accept Ether transfers.
3. Defines a function getBalance to retrieve the current balance of the contract.

Sendether Contract:

1. Declares a contract named sendether.
2. Implements an external receive function to accept Ether transfers.
3. Defines three functions (sendViaTransfer, sendViaSend, sendViaCall) to demonstrate different ways of sending Ether to another address.
4. Uses transfer, send, and call methods, with comments explaining the nuances and recommendations for each.

*/