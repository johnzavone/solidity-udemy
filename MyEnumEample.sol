// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.7;

contract test {
   enum FreshJuiceSize{ SMALL, MEDIUM, LARGE }
   FreshJuiceSize choice;
   FreshJuiceSize constant defaultChoice = FreshJuiceSize.MEDIUM;

   function setLarge() public {
      choice = FreshJuiceSize.LARGE;
   }
   function getChoice() public view returns (FreshJuiceSize) {
      return choice;
   }
   function getDefaultChoice() public pure returns (uint) {
      return uint(defaultChoice);
   }
}

contract CardDeck {
    enum Suit { Spades, Clubs, Diamonds, Hearts}
    enum Value { 
        Two, Three, Four, Five, Six, 
        Seven, Eight, Nine, Ten, 
        Jack, King, Queen, Ace 
    }
    struct Card {
        Suit suit;
        Value value;
    }
    
    Card public myCard;
    
    function pick_a_card(Suit _suit, Value _value) public returns (Suit, Value) {
        myCard.suit = _suit;
        myCard.value = _value;
        return (myCard.suit, myCard.value);
    }
}
