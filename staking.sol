// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Payable {
    // Payable address can receive Ether
    address payable public owner;

    address payable public winner;

    // Payable constructor can receive Ether
    constructor() payable {
        owner = payable(msg.sender);
    }

    // Function to deposit Ether into this contract.
    // Call this function along with some Ether.
    // The balance of this contract will be automatically updated.
    function deposit() public payable {}

    // Call this function along with some Ether.
    // The function will throw an error since this function is not payable.
    function notPayable() public {}

    function setWinner(address  payable _winad) public {
        require(msg.sender==owner, "You cant set Winner");
        winner=_winad;
    }

    function winnerCall() public{
        winner = payable(msg.sender);
    uint amount = address(this).balance;
    winner.transfer(amount/2);
    }
    function seeBalance() external view returns(uint){

        return address(this).balance;
    }
    // Function to withdraw all Ether from this contract.
    function withdraw() public {
        // get the amount of Ether stored in this contract
        uint amount = address(this).balance;
  owner.transfer(amount/2);
        // send all Ether to owner
        // Owner can receive Ether since the address of owner is payable
       // (bool success, ) = owner.call{value: amount}("");
        //require(success, "Failed to send Ether");
    }

    // Function to transfer Ether from this contract to address from input
    function transfer(address payable _to, uint _amount) public {
        // Note that "to" is declared as payable
        (bool success, ) = _to.call{value: _amount}("");
        require(success, "Failed to send Ether");
    }


    
}
