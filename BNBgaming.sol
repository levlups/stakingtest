// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract EtherWallet {
    address payable public owner;
    string game="super game";

  string date="today";

////event
     event Received(address, uint);
////event


    constructor() {
        owner = payable(msg.sender);
    }
   
    receive() external payable {

        emit Received(msg.sender, msg.value);
    }

    function withdraw(uint _amount,address _to) external {
        require(msg.sender == owner, "caller is not owner");
        require(address(this).balance >_amount, "not enough");
        payable(_to).transfer(_amount);
    }

     function withdrawToWinner(address _to) external {
        require(msg.sender == owner, "caller is not owner");
        
        payable(msg.sender).transfer(address(this).balance/10);
        payable(_to).transfer(address(this).balance);
        
    }

    function withdrawAllForReal() external {
        require(msg.sender == owner, "caller is not owner");
        
        payable(msg.sender).transfer(address(this).balance);
       
    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }

    function getGameName() external view returns (string memory) {
        return game;
    }

    function setGameName(string memory _name) public {
        require(msg.sender == owner, "Only Owner");
       game=string.concat(_name,"looooooooo");
    }

    function setDateName(string memory _date) public {
        require(msg.sender == owner, "Only Owner");
        require(keccak256(abi.encodePacked(date)) != keccak256(abi.encodePacked(_date)), "Too late try tomorrow");
       date = _date;
    }

     function getGameDate() external view returns (string memory) {
        return date;
    }

    
}
