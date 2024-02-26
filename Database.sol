// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// This contract defines a simple database structure allowing users to record personal details upon registration.

contract Createadatabase {
    // Struct defining the structure of a database entry
    struct database {
        string name;
        uint age;
        uint phonenumber;
        string houseaddress;
        string officeaddress;
        address walletaddress;
        string bestcolor;
    }

    // Array to store instances of the database entries
    database[] public info;

    // Function to insert a new database entry with user details
    function insert(
        string memory name,
        uint age,
        uint phonenumber,
        string memory houseaddress,
        string memory officeaddress,
        address walletaddress,
        string memory bestcolor
    ) public {
        // Create a new database entry with provided details
        database memory state = database(
            name,
            age,
            phonenumber,
            houseaddress,
            officeaddress,
            walletaddress,
            bestcolor
        );

        // Add the new database entry to the array
        info.push(state);
    }
}
