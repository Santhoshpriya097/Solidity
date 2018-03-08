pragma solidity ^0.4.18;


contract ERC20  {
  
   function totalSupply()public constant returns(uint256);
    function transfer(address _to,uint256 amount)public ;
    function mint(uint256 amount)public;
    function balanceof()public constant returns(uint256);
    function approve(address _spender,uint256 _value) returns(bool success);
    function allowance(address _owner,address _spender) constant returns(uint256 remaining);
    function transferFrom(address _from,address _to,uint256 _value) returns(bool success);
      event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint _value);
    
}
