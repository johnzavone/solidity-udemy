//SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.7;

contract Fabric {
   address[] public sums;
   address[] public tokens;

   //this example creates a new instance of class Sum with a passed argument
   function newSum() public {
      Sum sum = new Sum();
      sums.push(address(sum));
   }
   //this example creates a new instance of class Token 
   //with a passed argument to the Constructor
   function newToken(string memory _name) public {
      Token token = new Token(_name);
      tokens.push(address(token));
   }
   function getTokenName(uint8 _tokenId) public view returns (string memory) {
      string memory name = Token(tokens[_tokenId]).name();
      return name;
   }
}

contract Sum {
   function sum(uint x, uint y) public pure returns (uint) {
      return x + y;
   }
}

contract Token {
   string public name;
   constructor(string memory _name) {
      name = _name;
   }
}

