pragma solidity ^0.4.16;

contract Token{
    function totalSupply() constant returns (uint256 supply) {}
    function balanceOf(address _owner) constant returns (uint256 balance) {}
    function deposit(uint256 amount){}
    function withdraw(uint256 amount){}
    function transfer(address _to, uint256 _value) returns (bool success) {}
    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {}
    function approve(address _spender, uint256 _value) returns (bool success) {}
    function allowance(address _owner, address _spender) constant returns (uint256 remaining) {}
    
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}
contract StandardToken is Token{
    
     address _owner;
     mapping (address => uint256) balances;
     mapping(address => mapping(address => uint256)) alowed;
     uint256 public totalSupply;
     
     modifier check()
     {
         require(msg.sender == _owner);
         _;
     }
     
     function deposit(uint256 amount)public check()
     {
         balances[_owner] += amount;
     }
     
     function withdraw(uint256 amount)public check()
     {
         balances[_owner] -= amount;
     }
     
     function transfer(address _to,uint256 _value) returns(bool success) {
         if (balances[msg.sender] >= _value && _value > 0 ){
             
             balances[msg.sender] -= _value;
             balances[_to] += _value;
             Transfer(msg.sender,_to,_value);
             return true;
         }
         else{
             return false;
         }
     }
     
     function transferFrom(address _from,address _to,uint256 _value) returns(bool success) {
         if (balances[_from] >= _value && _value > 0 && alowed[_from][_to] >= _value){
             
             balances[_from] -= _value;
             balances[_to] += _value;
             alowed[_from][_to] -= _value;
             Transfer(_from,_to,_value);
             return true;
         }
         else{
             return false;
         }
     }
     
     function balanceOf(address _owner) constant returns(uint256 balance){
         return balances[_owner];
     }
     
     function approve(address _spender,uint256 _value) returns(bool success){
         alowed[msg.sender][_spender] = _value;
         Approval(msg.sender,_spender,_value);
         return true;
     }
     
     function allowance(address _owner,address _spender) constant returns(uint256 remaining){
         return alowed[_owner][_spender];
     }
     
      function transferOwnership(address newOwner) public check() {
    require(newOwner != address(0));
    OwnershipTransferred(_owner, newOwner);
    _owner = newOwner;
  }
}


contract TestCoin is StandardToken{
    string public name;
    uint8 public decimals;
    string public symbol;
    uint256 public unitsOneEthCanBuy;
    uint256 public totalEth;
    address public Wallet;
  
    function TestCoin(){
       _owner = msg.sender;
        balances[msg.sender] = 5000;
        totalSupply = 5000;
        Wallet = msg.sender;
        name = "Bank Wallet";
        symbol = "$$";
        decimals = 18;
    }
   
}


