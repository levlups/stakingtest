// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Bitcoin is ERC20, Ownable {
      uint256 deadline;
    uint256 _end;

    uint256 public wathTime;
    uint public cap=0;
    constructor() ERC20("Bitcoin", "Btc") {}


     modifier timesUp() {
        require(deadline <=block.timestamp,"deadline didnt pass");
          
        _;
    }

    function mint( uint256 amount) public onlyOwner timesUp {
        
        require(cap<20000 , "Cap reached !!!");
        
        cap+=amount;

      
        _end =(10 * 1 seconds);

       // * 1 days or * 1 year
        deadline = block.timestamp + _end ;

        
      
        go(amount);
    }

    function go(uint amount) private {
       
       
          _mint(msg.sender, amount);
    }

    

    

    

    
}
