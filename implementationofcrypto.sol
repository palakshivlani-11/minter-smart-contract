// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
contract mintyourcoins{
   address public minter;
   mapping(address => uint) public balance;   //hash table - initialkted and mapped to value of byte representation
   event send(address from , address to , uint amount);

// constructor is required to create new coins
   constructor() { 
       minter = msg.sender; // only the creator can mint new coins and store them in the hashtable
   }

   function mint(address receiver,uint amount) public {
       require(msg.sender == minter); // conditions
       require(amount < 1e60);  // max amount to be sent
       balance[receiver] += amount;
   }


// function which examines transactions feasibility
   function sent(address receiver , uint amount) public {
       require(amount <= balance[msg.sender] , "Insufficient balance");
       // if the transaction is possible function will send a send event which is a declaration for the transactions to be broadcasted
       balance[msg.sender] -= amount;
       balance[receiver] += amount;
       emit send(msg.sender,receiver,amount);
   }


   // as soon as the transaction is completed , it is added to the blockchain to know the details.

   //function to get the balance
   function getBalance(address _account) external view returns (uint){
       return balance[_account];
   }
}


// minter will generate current users address