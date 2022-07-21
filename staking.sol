
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Staking {
  address owner;
  mapping(bytes32 => address) public whitelistedTokens;
  mapping(address => mapping(bytes32 => uint256)) public accountBalances;

//////added this for the game 

string public message;
address gameLootAddress;
  uint public gameAmount= 100000;
 event Log(address indexed sender, string message);
  
/////////
  constructor() {
    owner = msg.sender;
  }

 function getOwner() external returns(address) {
    return owner;
  }

/// adding to Game Loot//
function addToGameAddress(uint256 amount, bytes32 symbol) external {
require(gameAmount >= amount, 'Insufficent funds');
    accountBalances[gameLootAddress][symbol] += amount;
    ERC20(whitelistedTokens[symbol]).transferFrom(msg.sender, gameLootAddress, amount);
  }
  
  
 function setMessage(string memory newMessage)public{
 
  require(msg.sender == owner, 'You have to be owner to set Game Message');
 message=newMessage;
  emit Log(msg.sender, newMessage);

 }
 
 function getMessage()public view returns(string memory){
 return message;
 }}

  function whitelistToken(bytes32 symbol, address tokenAddress) external {
    require(msg.sender == owner, 'This function is not public');

    whitelistedTokens[symbol] = tokenAddress;
  }

  function getWhitelistedTokenAddresses(bytes32 token) external returns(address) {
    return whitelistedTokens[token];
  }

  function depositTokens(uint256 amount, bytes32 symbol) external {
    accountBalances[msg.sender][symbol] += amount;
    ERC20(whitelistedTokens[symbol]).transferFrom(msg.sender, address(this), amount);
  }

  function withdrawTokens(uint256 amount, bytes32 symbol) external {
    require(accountBalances[msg.sender][symbol] >= amount, 'Insufficent funds');

    accountBalances[msg.sender][symbol] -= amount;
    ERC20(whitelistedTokens[symbol]).transfer(msg.sender, amount);
  }
}
