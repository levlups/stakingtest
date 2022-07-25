// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Bitcoin is ERC20, Ownable {
      uint256 deadline;
    uint256 _end;

    uint256 _random;
    
    constructor() ERC20("Bitcoin", "Btc") {}


    receive() external payable {}

     modifier timesUp() {
        require(deadline <=block.timestamp,"deadline didnt pass");
        _;
    }

    function mint( uint256 amount) public onlyOwner timesUp {
        
        require(ERC20(address(this)).totalSupply() <2000 , "Cap reached !!!");
        
        _end =(10 * 1 seconds);

       // * 1 days or * 1 year
        deadline = block.timestamp + _end ;

        
      
        goMint(amount);
    }

    function goMint(uint amount) private {
       
       
          _mint(msg.sender, amount);
    }


    function guess(uint num) public {
            _random=num;
      (bool sent, ) = msg.sender.call{value: 1 ether}("");
            require(sent, "Failed to send Ether");
      /*  uint answer = uint(
            keccak256(abi.encodePacked(blockhash(block.number - 1), block.timestamp))
        );

        if (_guess == answer) {
            (bool sent, ) = msg.sender.call{value: 1 ether}("");
            require(sent, "Failed to send Ether");
        }*/
    }

    

    

    

    
}
