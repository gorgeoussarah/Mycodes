// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
//to generate the time as uint starat and endat
contract Time {
    uint public Second = block.timestamp + 1 seconds;
    uint public ThirtySeconds = block.timestamp + 30 seconds;
    uint public Minute = block.timestamp + 1 minutes;
    uint public TwoMinute = block.timestamp + 2 minutes;
    uint public SevenMinute = block.timestamp + 7 minutes;
    uint public TenMinute = block.timestamp + 10 minutes;   
    uint public Hour = block.timestamp + 1 hours;
    uint public Day = block.timestamp + 1 days;
 
} 