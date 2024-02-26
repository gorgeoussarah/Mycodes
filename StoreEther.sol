// SPDX-License-Identifier: MIT
pragma solidity ^0.5.12;

// Smart contract representing a StoreEther with a fallback function
contract StoreEther {
    uint public value;

    // Function to set the value
    function set(uint _value) external {
        value = _value;
    }

    // Fallback function to reset the value when receiving ether
    function() external payable {
        value = 0;
    }
}

// Contract to interact with the StoreEther contract
contract ValueInteraction {
    // Function to call the non-existing 'setter()' function in StoreEther contract
    function callStoreEther(StoreEther _storeEther) public returns (bool) {
        // Calling a non-existing function in StoreEther contract
        (bool success,) = address(_storeEther).call(abi.encodeWithSignature("setter()"));
        require(success);

        // Sending ether to StoreEther contract
        address payable payableStoreEther = address(uint160(address(_storeEther)));
        return payableStoreEther.send(2 ether);
    }
}
