// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract EtherWallet {
    address payable public owner;
    string game="super game";
    constructor() {
        owner = payable(msg.sender);
    }

    receive() external payable {}

    function withdraw(uint _amount,address _to) external {
        require(msg.sender == owner, "caller is not owner");
        require(address(this).balance >_amount, "not enough");
        payable(_to).transfer(_amount);
    }

     function withdrawAll(address _to) external {
        require(msg.sender == owner, "caller is not owner");
        //require(address(this).balance >_amount, "not enough");
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
}
