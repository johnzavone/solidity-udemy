// SPDX-License-Identifier: Unlicensed

//change this to required solidity version
pragma solidity ^0.8.7;

//import statements

//interfaces

//libraries

contract My1stContract {

//Type declarations

//State variables

//Events

//Functions
//   constructor
//   fallback
//   other in order of visibility
//   revert functions

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
