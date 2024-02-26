// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Smart contract named "todolist" to manage a list of tasks.

contract Todolist {
    
    // Struct definition named "micro" representing a task with a title and completion status
    struct Micro {
        string title;
        bool completed;
    }

    // Dynamic array to store instances of the "micro" struct, representing the task list
    Micro[] public tech;

    // Function to insert a new task into the list
    function insert(string memory _title) public {
        // Push a new instance of the "micro" struct with the provided title and default completion status (false)
        tech.push(Micro(_title, false));
    }

    // Function to update the title of a task at a specific index in the list
    function update(uint index, string memory _title) public {
        // Modify the title of the task at the specified index
        tech[index].title = _title;
    }

    // Function to mark a task as completed at a specific index in the list
    function taskCompleted(uint index) public {
        // Set the completion status of the task at the specified index to true
        tech[index].completed = true;
    }
}





