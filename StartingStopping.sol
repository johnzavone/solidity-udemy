// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.7;

contract StartStopUpdateExample {

    address public owner;
    uint public myContractBalance;
    bool public paused;

    constructor() {
        owner = msg.sender;
    }

    function sendMoney() public payable {
        myContractBalance += msg.value;
    }

    function setPaused(bool _paused) public {
        require(msg.sender == owner, "You are not the owner");
        paused = _paused;
    }

    function withdrawAllMoney(address payable _to) public {
        require(owner == msg.sender, "You cannot withdraw.");
        require(!paused,"The contract is paused");
        _to.transfer(address(this).balance);
    }

        function destroySmartContract(address payable _to) public {
        require(msg.sender == owner, "You are not the owner");
        selfdestruct(_to);
    }
}