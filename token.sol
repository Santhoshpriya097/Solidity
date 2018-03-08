pragma solidity^0.4.0;
import "./ERC20.sol";
contract token is ERC20
{
     address owner;
     uint256 totalSupply_;
     string public name;
     string public symbol;
     uint256 public decimal;
    function token()
    {
        totalSupply_ = 10000;
         name = "token";
         symbol = "$$";
         decimal = 18;
         owner = msg.sender;
         balance[msg.sender] = totalSupply_;
     }
   modifier onlyOwner()
   {
        require(owner == msg.sender);
       _;
   }
  
  mapping(address=>uint256)balance;
  mapping(address => mapping(address => uint256)) alowed;
  function totalSupply()public constant returns(uint256)
  {
      return totalSupply_;
  }
  function transfer(address _to,uint256 amount)public onlyOwner()
  {
      require (amount < totalSupply_);
      balance[owner] -= amount;
     
  }
 function balanceof()public constant returns(uint256)
  {
      return(balance[owner]);
  }
  function mint(uint256 amount)public onlyOwner()  {
     
      balance[owner] += amount;
      require(balance[owner] <= totalSupply_);
    
  }
  
  
     function approve(address _spender,uint256 _value) returns(bool success){
         alowed[msg.sender][_spender] = _value;
         Approval(msg.sender,_spender,_value);
         return true;
     }
     
     function allowance(address _owner,address _spender) constant returns(uint256 remaining){
         return alowed[_owner][_spender];
     }
     
     
     function transferFrom(address _from,address _to,uint256 _value) returns(bool success) {
        require (balance[_from] >= _value && _value > 0 && alowed[_from][_to] >= _value);
             
             balance[_from] -= _value;
             balance[_to] += _value;
             alowed[_from][_to] -= _value;
             Transfer(_from,_to,_value);
             return true;
     }

}
