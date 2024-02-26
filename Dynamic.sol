// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Contract to manage an array of numbers with basic CRUD operations.

contract NumberArrayManager {

    // Array to store a list of numbers
    uint[] public numbers = [100, 200, 300, 400];

    // Function to add a new number to the array
    function pushNumber() public {
        numbers.push(400);
    }

    // Function to update a specific element in the array
    function updateNumber() public {
        numbers[2] = 80;
    }

    // Function to delete a specific element in the array
    function deleteNumber() public {
        delete numbers[2];
    }
}
/*
Explanation:

1. The contract has been renamed to NumberArrayManager 
to better reflect its purpose.
2. The array is named numbers and initialized with values [100, 200, 300, 400].
3. The pushNumber function allows adding a new number (400) to the end of the array.
4. The updateNumber function modifies the third element of the array, setting it to 80.
5. The deleteNumber function removes the value at the third index of the array.
*/