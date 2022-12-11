//SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.7;

contract SimpleMappingExample {

    mapping(uint8 => bool) public myMapping;
    mapping(address => bool) public myAddressMapping;

    function setValue(uint8 _index) public {
        myMapping[_index] = true;
    }

    function setMyAddressToTrue() public {
        myAddressMapping[msg.sender] = true;
    }

}