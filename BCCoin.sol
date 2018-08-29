
pragma solidity ^0.4.21;

import "Interface.sol";            // change this line


contract BCCoin is Interface {

    uint256 constant private MAX_UINT256 = 2**256 - 1;
    // declare balances variable here
    mapping (address => mapping (address => uint256)) public allowed;


   
    string public name;                   //fancy name: eg Simon Bucks
    uint8 public decimals;                //How many decimals to show.
    string public symbol;                 //An identifier: eg SBX
    uint8 public tokenValue;              //token value in ethers
    address public Owner;                 //address account who deplyed the contract       
   
    mapping (address => uint256) public balances;

    constructor (
        uint256 _initialAmount,
        string _tokenName,
        uint8 _decimalUnits,
        string _tokenSymbol,
        uint8 _tokenValue
    ) public {
       Owner = msg.sender;
       tokenValue = _tokenValue;
       symbol = _tokenSymbol;
       decimals = _decimalUnits;
       name = _tokenName;
       balances[msg.sender] = _initialAmount;
       
       
    }


    function transfer(address _to, uint256 _value) public  {
     
       
           balances[Owner] -= _value;
           balances[_to]  += _value;
           //Transfer(msg.sender, _to, _value);
       
       
    }

    function transferFrom(address _from, address _to, uint256 _value) public  {
        uint256 allowance = allowed[_from][msg.sender];
       
             balances[_from] -= _value;
             balances[_to] += _value;

        if (allowance < MAX_UINT256) {
            allowed[_from][msg.sender] -= _value;
             
        }
     
    }    
   
    function approve(address _spender, uint256 _value) public  {
      allowed[Owner][_spender ]= _value;
       
    }

    function getTokens()  public payable {
         uint256 amount = msg.value / tokenValue;
        balances[Owner] -= amount;
         balances[msg.sender] += amount;
     


    }

    function getEthers(uint256 _tokens) public  {
        uint256 Etheramount = _tokens * tokenValue;
        balances[msg.sender] -= _tokens;
        balances[Owner] += _tokens;
        msg.sender.transfer(Etheramount); 

       

    }
    function getBalance() constant returns (uint) {
     return msg.sender.balance;
    }
    
}
