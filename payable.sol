// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Payable {
    // Payable address can receive Ether
    address payable public owner;
     uint public balancio;

   mapping(address => uint) public balances;
    // Payable constructor can receive Ether
    constructor() payable {
        owner = payable(msg.sender);
    }

   event Deposit(uint _value);

    // Function to deposit Ether into this contract.
    // Call this function along with some Ether.
    // The balance of this contract will be automatically updated.

   receive()  external payable {
    balancio = msg.value;
      emit  Deposit(msg.value);
        require(msg.value > 1*10**18,"too low amount");
        balances[msg.sender]+=msg.value;
    }


    // Call this function along with some Ether.
    // The function will throw an error since this function is not payable.
    function notPayable() public {}

    // Function to withdraw all Ether from this contract.
    function withdraw() public {
        // get the amount of Ether stored in this contract
       // uint amount = address(this).balance;

        uint amount = balances[msg.sender];

        // send all Ether to owner
        // Owner can receive Ether since the address of owner is payable
        (bool success, ) = owner.call{value: amount}("");
         balances[msg.sender] -=  amount ;
        require(success, "Failed to send Ether");
    }

    // Function to transfer Ether from this contract to address from input
    function transfer(address payable _to, uint _amount) public {
        // Note that "to" is declared as payable
        (bool success, ) = _to.call{value: _amount}("");
        require(success, "Failed to send Ether");
    }

    function seeBalance()public view returns(uint){
        return address(this).balance;
    }
}
