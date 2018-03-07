pragma solidity^0.4.0;
contract votingg
{
    uint256 valid;
    uint256 t;
    uint256 tot_count;
  struct candidate
  {
      string name;
      uint256 id;
      uint256 count; 
    }
    struct ppl
    {
        uint256 userid;
    }                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
    mapping(uint256 => candidate)vote;
   mapping(uint256 => ppl)voting;
   
    function votingg()
   {
        t = now+ 1 days;
        valid = now + 5 days;
   }
   modifier checkcan()
   {
       require(valid>=now);
       _;
   }
   modifier check(uint256 user)
   {
      require( voting[user].userid != user);
      require(t>=now);
       _;
   }
  
    function get(uint256 id,string name)public checkcan()
    {
        vote[id].id=id;
        vote[id].name=name;
    }
   
    function votee(uint256 userid,uint256 id)public check(userid)
    {
            voting[userid].userid=userid;
            vote[id].count +=1;
            tot_count +=1;
        }
        
     function display(uint256 id)public constant returns(uint256,string,uint256)
    {
        return (vote[id].id,vote[id].name,vote[id].count);
    }
    function totalvote()public constant returns(uint256)
    {
        return(tot_count);
    }
    
    function winner()public constant returns(string)
    {
        if(vote[1].count > vote[2].count && vote[1].count > vote[3].count)
        {
            return ("candidate1 wins");
            
        }
        else if(vote[2].count > vote[1].count && vote[2].count > vote[3].count)
        {
            
            return ("candidate2 wins");
        }
        else 
        {
             return ("candidate3 wins");
        }
    }
}
