//SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.4;

//this does not appear to be correct reference
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";

contract InvokeToken {

   function invokeTotalSupply(address _address) public view returns (uint256) {
      IERC20 token = IERC20(_address);
      return token.totalSupply();
    } 

}
