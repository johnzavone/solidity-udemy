// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.7;

//import statements

//interfaces

//libraries

contract Ownable {
    
    address public _owner;

    constructor () internal {
        _owner = msg.sender;
    }
    
    //Throws if called by any account other than the owner
    modifier onlyOwner() {
    require(isOwner(), "Ownable: caller is not the owner"); _;
    }

    //Returns true if the caller is the current owner
    function isOwner() public view returns (bool) { 
        return (msg.sender == _owner);
    }    
}

contract Item{
    uint public priceInWei;
    uint public pricePaid;
    uint public index;

    ItemManager parentContract;

    constructor(ItemManager _parentContract, uint _priceInWei, uint _index) public {
        priceInWei = _priceInWei;
        index = _index;
        parentContract = _parentContract;
    }

    receive() external payable {
        require(pricePaid == 0,"Item is already paid");
        require(priceInWei == msg.value,"Only exact payment is accepted");
        pricePaid += msg.value;
        (bool success, ) = address(parentContract).call{value:msg.value}(abi.encodeWithSignature("triggerPayment(uint256)", index));
        require(success, "Delivery did not work");
    }

    fallback() external {}

}

contract ItemManager is Ownable {

//Type declarations

    enum SupplyChainState {Created, Paid, Delivered}

    struct S_Item {
        Item _item;
        string _identifier;
        uint _itemPrice;
        ItemManager.SupplyChainState _state;
    }

    mapping(uint => S_Item) public items;

    event SupplyChainStep(uint _itemIndex, uint _step, address _itemAddress);

//State variables
    uint itemIndex;

//Events

//Functions
//   constructor
//   fallback
//   other in order of visibility
    function createItem(string memory _identifier, uint _itemPrice) public onlyOwner {
        Item item = new Item(this, _itemPrice, itemIndex);
        items[itemIndex]._item = item;
        items[itemIndex]._identifier =_identifier;
        items[itemIndex]._itemPrice =_itemPrice;
        items[itemIndex]._state = SupplyChainState.Created;
        emit SupplyChainStep(itemIndex, uint(items[itemIndex]._state),address(item));
        itemIndex++;
    }

    function triggerPayment(uint _itemIndex) public payable {
        require(items[_itemIndex]._itemPrice == msg.value, "Only exact payments accepted");
        require(items[_itemIndex]._state == SupplyChainState.Created, "The item is already further in the supply chain");
        items[_itemIndex]._state = SupplyChainState.Paid;
        emit SupplyChainStep(_itemIndex, uint(items[_itemIndex]._state), address(items[_itemIndex]._item));
    }

    function triggerDelivery(uint _itemIndex) public onlyOwner {
        require(items[_itemIndex]._state == SupplyChainState.Paid, "The item is in a different position in the supply chain");
        items[_itemIndex]._state = SupplyChainState.Delivered;
        emit SupplyChainStep(_itemIndex, uint(items[_itemIndex]._state), address(items[_itemIndex]._item));
    }
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
