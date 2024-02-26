//Crowd funding contract
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

interface IERC20 {

    function transfer(address, uint) external returns (bool);
 
    function transferFrom(address, address, uint) external returns (bool);

}
 
contract CrowdFund {

    event Launch(

        uint id,

        address indexed creator,

        uint goal,

        uint32 startAt,

        uint32 endAt

    );

    event Cancel(uint id);

    event Pledge(uint indexed id, address indexed caller, uint amount);

    event Unpledge(uint indexed id, address indexed caller, uint amount);

    event Claim(uint id);

    event Refund(uint id, address indexed caller, uint amount);
 
    struct Campaign {

        // Creator of campaign

        address creator;

        // Amount of tokens to raise

        uint goal;

        // Total amount pledged

        uint pledged;

        // Timestamp of start of campaign

        uint32 startAt;

        // Timestamp of end of campaign

        uint32 endAt;

        // True if goal was reached and creator has claimed the tokens.

        bool claimed;

    }
 
    IERC20 public immutable token;

    // Total count of campaigns created.

    // It is also used to generate id for new campaigns.

    uint public count;

    // Mapping from id to Campaign

    mapping(uint => Campaign) public campaigns;

 
   // Mapping to track the amount pledged for each campaign and each pledger
mapping(uint => mapping(address => uint)) public pledgedAmount;

// Constructor initializing the token variable with the provided ERC-20 token address
constructor(address _token) {
    token = IERC20(_token);
}

// Function for launching a new crowdfunding campaign
function launch(uint _goal, uint32 _startAt, uint32 _endAt) external {
    // Check if the start timestamp is valid
    require(_startAt >= block.timestamp, "start at < now");
    // Check if the end timestamp is valid and follows the start timestamp
    require(_endAt >= _startAt, "end at < start at");
    // Check if the campaign duration does not exceed the maximum allowed duration
    require(_endAt <= block.timestamp + 90 days, "end at > max duration");

    // Increment the count to generate a unique ID for the new campaign
    count += 1;

    // Create a new Campaign struct with the provided details and store it in the campaigns mapping
    campaigns[count] = Campaign({
        creator: msg.sender,
        goal: _goal,
        pledged: 0,
        startAt: _startAt,
        endAt: _endAt,
        claimed: false
    });

    // Emit a Launch event to log the creation of the new campaign
    emit Launch(count, msg.sender, _goal, _startAt, _endAt);
}

// Function for canceling a crowdfunding campaign
function cancel(uint _id) external {
    // Retrieve the campaign details from storage
    Campaign memory campaign = campaigns[_id];

    // Check if the caller is the creator of the campaign
    require(campaign.creator == msg.sender, "not creator");
    // Check if the campaign has not started yet
    require(block.timestamp < campaign.startAt, "started");

    // Delete the campaign from the campaigns mapping
    delete campaigns[_id];

    // Emit a Cancel event to log the cancellation of the campaign
    emit Cancel(_id);
}

// ... (The remaining functions are already commented)

 
    // Function for pledging tokens to a campaign
function pledge(uint _id, uint _amount) external {
    // Retrieve campaign details from storage
    Campaign storage campaign = campaigns[_id]; 
    // Check if the campaign has started
    require(block.timestamp >= campaign.startAt, "not started");
    // Check if the campaign has not ended 
    require(block.timestamp <= campaign.endAt, "ended"); 
    // Increase the total pledged amount for the campaign
    campaign.pledged += _amount; 
    // Record the pledged amount for the caller
    pledgedAmount[_id][msg.sender] += _amount; 
    // Transfer tokens from the caller to the contract
    token.transferFrom(msg.sender, address(this), _amount);
    // Emit Pledge event to log the pledge 
    emit Pledge(_id, msg.sender, _amount); 
}

// Function for canceling a pledge and receiving a refund
function unpledge(uint _id, uint _amount) external {
    // Retrieve campaign details from storage
    Campaign storage campaign = campaigns[_id]; 
     // Check if the campaign has not ended
    require(block.timestamp <= campaign.endAt, "ended");
    // Decrease the total pledged amount for the campaign
    campaign.pledged -= _amount;
    // Reduce the recorded pledged amount for the caller 
    pledgedAmount[_id][msg.sender] -= _amount; 
    // Transfer tokens back to the caller
    token.transfer(msg.sender, _amount);
    // Emit Unpledge event to log the cancellation 
    emit Unpledge(_id, msg.sender, _amount); 
}

   // Function for the campaign creator to claim pledged tokens after meeting the goal
function claim(uint _id) external {
    // Retrieve campaign details from storage
    Campaign storage campaign = campaigns[_id];
    // Check if the caller is the creator 
    require(campaign.creator == msg.sender, "not creator"); 
    // Check if the campaign has ended
    require(block.timestamp > campaign.endAt, "not ended"); 
    // Check if the goal has been reached
    require(campaign.pledged >= campaign.goal, "pledged < goal");
    // Check if tokens have not been claimed already 
    require(!campaign.claimed, "claimed"); 
    // Mark the campaign as claimed
    campaign.claimed = true;
    // Transfer pledged tokens to the campaign creator 
    token.transfer(campaign.creator, campaign.pledged); 
    // Emit Claim event to log the successful claim
    emit Claim(_id); 
}

// Function for users to request a refund if the campaign ends without reaching the goal
function refund(uint _id) external {
     // Retrieve campaign details from storage
    Campaign memory campaign = campaigns[_id];
    // Check if the campaign has ended
    require(block.timestamp > campaign.endAt, "not ended");
    // Check if the goal has not been reached 
    require(campaign.pledged < campaign.goal, "pledged >= goal"); 
    // Retrieve the pledged amount for the caller
    uint bal = pledgedAmount[_id][msg.sender];
    // Set the recorded pledged amount to zero 
    pledgedAmount[_id][msg.sender] = 0; 
    // Transfer pledged tokens back to the caller
    token.transfer(msg.sender, bal); 
    // Emit Refund event to log the refund request
    emit Refund(_id, msg.sender, bal); 
}

}


