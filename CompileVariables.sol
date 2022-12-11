pragma solidity ^0.8.7;

contract WorkingWithVariables {
    uint256 public myUint;
    function setMyUint(uint _myUint) public {
        myUint=_myUint;
    }

    address public myAddress;
    function setMyAddress(address _address) public {
        myAddress=_address;
    }

    function getBalanceOfAddress() public view returns(uint) {
        return myAddress.balance;
    }

    string public myString;
    function setMyString(string memory _myString) public {
        myString=_myString;
    }
}