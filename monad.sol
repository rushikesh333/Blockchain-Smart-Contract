// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
/* MonadToken Contract */
contract MonadToken {
    string public name = "MonadToken";
    string public symbol = "MON";
    uint8 public decimals = 18 ;
    uint256 public totalSupply ;

    address public owner ;
    // keep track of user token balance 
    mapping(address => uint256) public balanceOf;
    // logs of every tpokens transfer
    event Transfer(address indexed from,address indexed to,uint256 value);
    //Restricts access to owner only 
    modifier onlyOwner() {
        require(msg.sender == owner,"only owner can perform this action");
        _;
    }
    // set the developer as the owner of contrct 
    constructor() {
        owner = msg.sender;
    }
    /* Mint Function
    allow the user to create new supply of the token and assign them to user */
    function mint (address to,uint256 amount ) external onlyOwner {
        require(to !=address(0),"cannot mint to zero address");
        totalSupply += amount ;
        balanceOf[to] += amount;
        emit Transfer(address(0), to, amount);
    }
/* Transfer Function
    now let the user sends token to another wallet address also need to check sufficient balance before transfer*/
     function SendTokens (address to, uint256 amount) external {
      require(to !=address(0),"invalid recipient") ;
        require(balanceOf[msg.sender] >= amount,"Tokens Innsufficient"); 

        balanceOf[msg.sender] -=amount;
        balanceOf[to] += amount;
        emit Transfer(msg.sender, to, amount);
    }


}