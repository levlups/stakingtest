
// SPDX-License-Identifier: MIT
pragma solidity >=0.8.15;

contract FirstContract {

 
    address owner;
    uint256 deadline;
    uint256 _end;
  mapping(address => uint) public balances;

    event Deposit(address indexed _from, uint _value);


            constructor()  {
            owner=msg.sender;
            
            }



    receive() external payable {
      
    
        updateBalance(msg.value); 
        

        //emit Deposit(msg.sender, msg.value);
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }


    modifier timesUp() {
        require((deadline - block.timestamp)>0,"TIMES UP!!!!");
        _;
    }



    function updateBalance(uint newBalance) private {
      balances[msg.sender] = newBalance;
   }

    function deposit(uint256 amount) public payable {
        require(msg.value == amount);
          updateBalance(msg.value); 
          emit Deposit(msg.sender, msg.value);
    }

    function Savings(uint256 numberOfDays) public payable {
        owner = msg.sender;

        _end =(numberOfDays * 1 seconds);

       // * 1 days or * 1 year
        deadline = block.timestamp + _end ;
    }


        function getRemainder() timesUp public view returns(uint){
            return deadline - block.timestamp;
        }

        function withdraw() public  onlyOwner payable {
            require(block.timestamp >= deadline,"deadline didnt pass");
            payable(msg.sender).transfer(balances[msg.sender]); 
        }
}
