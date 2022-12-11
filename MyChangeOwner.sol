// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.7;

contract MyChangeOwner {

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
        require(msg.sender == owner, "Only the owner can pause the contract");
        paused = _paused;
    }

    function withdrawAllMoney(address payable _to) public {
        require(owner == msg.sender, "Only the owner can initiate withdrawal");
        require(!paused,"The contract is paused");
        _to.transfer(address(this).balance);
    }

    function ChangeOwnerTo(address _to) public {
        require(owner == msg.sender, "Only the owner can change the contract to a new owner");
        require(!paused,"The contract is paused");
        owner = _to;
    }

        function destroySmartContract(address payable _to) public {
        require(msg.sender == owner, "You are not the owner");
        selfdestruct(_to);
    }
}