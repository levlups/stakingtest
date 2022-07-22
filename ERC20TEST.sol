// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract Payable {
    // Payable address can receive Ether
    address payable public owner;

    address payable public winner;

    IERC20 supertoke = IERC20(0xd9145CCE52D386f254917e481eB44e9943F39138);

    // Payable constructor can receive Ether
    constructor() payable {
        owner = payable(msg.sender);
    }


function depositToken(uint _amount) public{
  
       
 supertoke.approve(msg.sender, _amount);

//supertoke.balanceOf(msg.sender);
  /*require(
            supertoke.allowance(msg.sender,msg.sender) >= _amount,
            "Token 1 allowance too low"
        );*/
        //  supertoke.transferFrom(msg.sender, address(this), _amount);
        supertoke.transfer(msg.sender, _amount);
//_safeTransferFrom(supertoke,msg.sender, address(this), _amount);
}

function _safeTransferFrom(
        IERC20 token,
        address sender,
        address recipient,
        uint amount
    ) private {
        bool sent = token.transferFrom(sender, recipient, amount);
        require(sent, "Token transfer failed");
    }
    // Function to deposit Ether into this contract.
    // Call this function along with some Ether.
    // The balance of this contract will be automatically updated.
    function deposit() public payable {}

    // Call this function along with some Ether.
    // The function will throw an error since this function is not payable.
    function notPayable() public {}

    function setNewOwner() public {}

    function setWinner(address payable _winad) public {
        require(msg.sender== owner, "You cant set Winner");
        
        winner=_winad;
    }

    function winnerCall() public{
        
    uint amount = address(this).balance;
     require(amount>0, "Game Over Bank empty");
     require(winner != address(0),"winner not designated");
      
    winner.transfer(amount-10);
    
    owner.transfer(10);
    }
    function seeBalance() external view returns(uint){

        return address(this).balance;
    }
    // Function to withdraw all Ether from this contract.
    function withdraw() public {

           
        // get the amount of Ether stored in this contract
        uint amount = address(this).balance;
  
        // send all Ether to owner
        // Owner can receive Ether since the address of owner is payable
        (bool success, ) = owner.call{value: amount}("");
        require(success, "Failed to send Ether");
    }

    // Function to transfer Ether from this contract to address from input
    function transfer(address payable _to, uint _amount) public {
        // Note that "to" is declared as payable
        require(msg.sender==owner, "Only owner can transfer");
        (bool success, ) = _to.call{value: _amount}("");
        require(success, "Failed to send Ether");
    }


    
}
