// SPDX-License-Identifier: Unlicensed

//change this to required solidity version
pragma solidity ^0.8.7;

//import statements
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

//interfaces

//libraries

contract SharedWallet is Ownable {

//Type declarations
    struct UserDetails {
        uint allowance;
        uint claimsMade;
    }

//State variables
    mapping(address => UserDetails) public users;    //holds benficiary details by address
    uint public totalAllowances;    //total allowances allocated as a %
    uint public totalClaims;    //total claims made to date
    uint public contractBalance; //total balance in contract
      

//Events
    event ClaimEvent(address indexed _forWho, address indexed _byWhom, uint _sentAmount);

//Functions

// The usual constructor to set owner and onlyOwner modifier are not required here because in the imported Ownable (see notes)

    //fallback
    receive() external payable {
        SendMoney();
    }

    //anyone can send to wallet
    function SendMoney() public payable {
        contractBalance = address(this).balance;
    }

    // users can withdraw share of total funds to date in accordance with allocation
    function ClaimMoney(address payable _to, uint _amount) public {
        require(!isOwner(), "The owner should use ownerWithdraw function");
        require(address(this).balance > 0, "There is no money in the wallet to claim");
        require(users[msg.sender].allowance > 0,"You do not have any allowance");
        uint fullAllowance = users[msg.sender].allowance * (address(this).balance + totalClaims)/100;
        uint allowanceRemaining = 0;    //initialises only
        if (fullAllowance > users[msg.sender].claimsMade) {
            allowanceRemaining = fullAllowance - users[msg.sender].claimsMade;
        }
        require(_amount <= allowanceRemaining, "The amount is too high");
        users[msg.sender].claimsMade += _amount;
        totalClaims += _amount;
        contractBalance = address(this).balance - _amount;
        _to.transfer(_amount);
        emit ClaimEvent(_to, msg.sender, _amount);
    }
  
    //owner can set who gets an allowance
    function SetAllowance(address _user, uint _allowancePercentage) public onlyOwner {
        require(_user != owner(), "An allowance is not required for the owner");
        require(users[_user].allowance == 0, "The address already has an allowance");
        require(totalAllowances + _allowancePercentage <= 100,"This would over-allocate the allowances");
        users[_user].allowance = _allowancePercentage;
        totalAllowances += _allowancePercentage;
    }
 
    //owner can withdraw as much as desired
    function ownerWithdraw(address payable _to, uint _amount) public onlyOwner {
        require(_amount <= address(this).balance,"Amount is larger than contract balance");
        contractBalance = address(this).balance - _amount;
        _to.transfer(_amount);
    }

    function isOwner() view public returns(bool) {
        return owner() == msg.sender;
    }

    function renounceOwnership() public view override onlyOwner {
        revert("can't renounceOwnership here"); //not possible with this smart contract
    }

}


//contract My2ndContract {

//as above

//}


// Code layout best practice
// see https://www.tutorialspoint.com/solidity/solidity_style_guide.htm
// Indentation − Use 4 spaces instead of tab to maintain indentation level. Avoid mixing spaces with tabs.
// Two Blank Lines Rule − Use 2 Blank lines between two contract definitions.
// One Blank Line Rule − Use 1 Blank line between two functions. In case of only declaration, no need to have blank lines.
// Maximum Line Length − A single line should not cross 79 characters so that readers can easily parse the code.
// Wrapping rules − First argument be in new line without opening parenthesis. Use single indent per argument. Terminating element ); should be the last one.
// Source Code Encoding − UTF-8 or ASCII encoding is to be used preferably.
// Imports − Import statements should be placed at the top of the file just after pragma declaration.
// Order of Functions − Functions should be grouped as per their visibility, ie. after constructor - external, external view, external pure, public, internal, private functions...
// String declaration − Use double quotes to declare a string instead of single quote.
// Elements should be layout in following order: Pragma statements, Import statements, Interfaces, Libraries, Contracts
// Within Interfaces, libraries or contracts the order should be as − Type declarations, State variables, Events, Functions
// Naming conventions:
//    Use CapWords style for Contracts, Libraries, Structs, Events, Enums.
//    Use mixedCase style for functions, local and state variables, modifyers.
//    Use ALL_CAP style for constants.
// Contract and Library name should match their file names - In case of multiple contracts/libraries in a file, use name of core contract/library.

// Notes:
// The usual constructor to set owner and onlyOwner modifier are not required here because in the imported Ownable (see notes)
//   constructor() {
//       owner = msg.sender;
//   }
//   modifier onlyOwner() {
//       require(msg.sender == owner, "You are not allowed - only the owner can do this.");
//       _;
//   }