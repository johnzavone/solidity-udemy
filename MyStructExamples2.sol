//SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.7;

contract MappingsStructExample {

    struct MemberDetails {
        uint balance;
        int256 numPayments;
        bool whitelist;
        mapping(int =>uint) payments;
    }

    mapping(address => MemberDetails) public Member;

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function sendMoney() public payable {
     Member[msg.sender].balance += msg.value;
     Member[msg.sender].numPayments+=1;
     Member[msg.sender].payments[Member[msg.sender].numPayments]=msg.value;
    }

    function withdrawMoney(address payable _to, uint _amount) public {
        require(Member[msg.sender].balance >= _amount,"Not enough funds");
        uint BalanceToSend=_amount;
        Member[msg.sender].balance -= _amount;
        _to.transfer(BalanceToSend);
    }
}
