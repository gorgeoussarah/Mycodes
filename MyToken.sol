// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// Specifies compatibility with Solidity compiler version 0.8.0 and above.

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// Imports the ERC20 contract from the OpenZeppelin library.

contract MyToken is ERC20 {
// Defines a contract named MyToken that inherits from the ERC20 contract.

    mapping(address => uint) public staked;
    // Public mapping to store the amount staked by each address.
    mapping(address => uint) private stakedFromTS;
    // Private mapping to store the timestamp when an address last staked.

    constructor() ERC20("MyToken", "MTK") {
        // Constructor function to initialize the MyToken contract.
        _mint(msg.sender, 1000);
        // Mints 1000 tokens and assigns them to the contract deployer.
    }

    function stake(uint amount) external {
        // Function to stake a specified amount of tokens.
        require(amount > 0, "Amount is <= 0");
        // Requires the staking amount to be greater than 0.
        require(balanceOf(msg.sender) >= amount, "Balance is <= Amount");
        // Requires the sender's balance to be greater than or equal to the staking amount.
        _transfer(msg.sender, address(this), amount);
        // Transfers the staking amount from the sender to the contract.

        if (staked[msg.sender] > 0) {
            claim();
        }
        // Calls the claim function if the sender had already staked before.
        stakedFromTS[msg.sender] = block.timestamp;
        // Updates the timestamp of the last stake from the sender.
        staked[msg.sender] += amount;
        // Increases the staked amount for the sender.
    }

    function unstake(uint amount) external {
        // Function to unstake a specified amount of tokens.
        require(amount > 0, "Amount is <= 0");
        // Requires the unstaking amount to be greater than 0.
        require(staked[msg.sender] > 0, "You did not stake with us");
        // Requires the sender to have staked before.
        stakedFromTS[msg.sender] = block.timestamp;
        // Updates the timestamp of the last stake from the sender.
        staked[msg.sender] -= amount;
        // Decreases the staked amount for the sender.
        _transfer(address(this), msg.sender, amount);
        // Transfers the unstaked amount from the contract to the sender.
    }

    function claim() public {
        // Function to claim rewards based on the staked amount and duration.
        require(staked[msg.sender] > 0, "Staked is <= 0 ");
        // Requires the sender to have a positive staked amount.
        uint secondsStaked = block.timestamp - stakedFromTS[msg.sender];
        // Calculates the duration in seconds since the last stake.
        uint rewards = staked[msg.sender] * secondsStaked / 3.154e7;
        // Calculates rewards based on the staked amount and duration.
        _mint(msg.sender, rewards);
        // Mints and assigns the calculated rewards to the sender.
        stakedFromTS[msg.sender] = block.timestamp;
        // Updates the timestamp of the last stake from the sender.
    } 
}
/*Explanation:

1. pragma solidity ^0.8.0;: Specifies compatibility with Solidity compiler 
version 0.8.0 and above.
2. import "@openzeppelin/contracts/token/ERC20/ERC20.sol";: Imports 
the ERC20 contract from the OpenZeppelin library.
3. contract MyToken is ERC20 { ... }: Defines a contract named MyToken 
that inherits from the ERC20 contract.
4. mapping(address => uint) public staked;: Public mapping to store the 
amount staked by each address.
5. mapping(address => uint) private stakedFromTS;: Private mapping to 
store the timestamp when an address last staked.
6. constructor() ERC20("MyToken", "MTK") { ... }: Constructor function 
to initialize the MyToken contract.
7. function stake(uint amount) external { ... }: Function to stake a 
specified amount of tokens.
8. function unstake(uint amount) external { ... }: Function to unstake 
a specified amount of tokens.
9. function claim() public { ... }: Function to claim rewards based 
on the staked amount and duration.

*/
