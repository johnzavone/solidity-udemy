// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.16;

contract SendMoneyExamples {

    uint public BalanceReceived;
    uint public RemainingBalance;
    uint public TimestampReceived;

    function ReceiveMoney() public payable {
        BalanceReceived += msg.value;
        TimestampReceived = block.timestamp;
        RemainingBalance = BalanceReceived;
    }

    function ReturnMoney() public {
        address payable to = payable(msg.sender);
        to.transfer(getBalance());
    }

    function SendMoney(address payable _to) public {
        if (block.timestamp>TimestampReceived + 60) {
            _to.transfer(address(this).balance);
            RemainingBalance = address(this).balance;
        }
        else {

        }
        
    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

}
