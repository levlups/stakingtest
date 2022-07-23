// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Staking {
  address public owner;

  uint public etherDonations;
  mapping(string => uint) public tokenDonations;
  mapping(string => address) public allowedTokens;

  constructor() {
    owner = msg.sender;
  }

  function allowedToken(string calldata symbol, address tokenAddress) external onlyOwner {
  

    allowedTokens[symbol] = tokenAddress;
  }

  receive() external payable{

      etherDonations += msg.value;

  }

  function approveTokens(uint amount,string calldata symbol)external  {
      require(allowedTokens[symbol] != address(0),"This is mot allowed");

       IERC20(allowedTokens[symbol]).approve(msg.sender,amount);

      

      //IERC20(allowedTokens[symbol]).transferFrom(msg.sender,address(this),amount);
  }

  function receiveTokens(uint amount,string calldata symbol)external  {
      require(allowedTokens[symbol] != address(0),"This is mot allowed");

       //IERC20(allowedTokens[symbol]).approve(msg.sender,amount);

      

      IERC20(allowedTokens[symbol]).transferFrom(msg.sender,address(this),amount);
  }

  function ownerWithdrawEther(uint amount)external onlyOwner{
      require(etherDonations >= amount,"Insufficient funds");
      payable(msg.sender).transfer(amount);
      etherDonations -= amount;
  }
   function ownerWithdrawTokens(uint amount,string calldata symbol)external onlyOwner{
      require(tokenDonations[symbol] >= amount,"Insufficient funds");
      IERC20(allowedTokens[symbol]).transfer(msg.sender,amount);
      tokenDonations[symbol] -= amount;
  }

  modifier onlyOwner{
      require(msg.sender == owner, "This function is not public");
      _;
  }

}
