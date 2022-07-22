// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract EtherWallet {

     mapping (address => uint) public pendingWithdrawals;
    address payable public owner;
    string public game="super game";

  string public date="today";
  
////event
     event Received(address, uint);
////event


    constructor() {
        owner = payable(msg.sender);
    }
   
    receive() external payable {
          pendingWithdrawals[msg.sender] += msg.value;
        emit Received(msg.sender, msg.value);
    }
 

     modifier onlyOwner {
      require(msg.sender == owner,"caller is not owner");
      _;
   }


   modifier enoughLoot {
      require(address(this).balance > 0,"Loot is at O");
      _;
   }

   modifier checkPlLoot {
       require(pendingWithdrawals[msg.sender] > 0, "you have no funds");
      _;
   }

   function withdrawFromGame() external  checkPlLoot{
       uint playerBlalance=pendingWithdrawals[msg.sender]; 
      
        payable(msg.sender).transfer(playerBlalance);
        pendingWithdrawals[msg.sender]-=playerBlalance;
    }

    /*function withdraw(uint _amount,address _to) external onlyOwner enoughLoot{
       
        require(address(this).balance >_amount, "not enough");
        payable(_to).transfer(_amount);
    }*/

     function withdrawToWinner(address _to) external onlyOwner enoughLoot{
        
        
        payable(msg.sender).transfer(address(this).balance/10);
        
        payable(_to).transfer(address(this).balance);
        
    }

    function withdrawAllForReal() external onlyOwner enoughLoot{
        
        
        payable(msg.sender).transfer(address(this).balance);
       
    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }

  

    function setGameName(string memory _name) public onlyOwner{
       
       game=string.concat(_name,"looooooooo");
    }

    function setDateName(string memory _date) public onlyOwner{
        
        require(keccak256(abi.encodePacked(date)) != keccak256(abi.encodePacked(_date)), "Too late try tomorrow");
       date = _date;
    }

   

     function testy() external view returns (string memory lol,string memory lol1) {
       lol= date;
       
       lol1 =game;
    }

    
}
