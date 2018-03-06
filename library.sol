pragma solidity^0.4.0;
contract lib
{ 
   
    address own;
        uint endtime=now+100 days;
    struct l
    {
        string[] bname;
        uint256[] bno;
        uint256[] avail;
        
    }
    struct stu
    {
        string[] sname;
        uint256[] rolno;
        uint256 count;
        
    }
    mapping(address=>l)map;
    mapping(uint256=>stu)mapp;
    mapping(uint256=>mapping(address=>uint256))map1;
    mapping(uint256=>mapping(address=>uint256))map2;
    function lib()public
    {
        uint t=now+5 days;
    }
   
    function getb(string _bname,uint256 _bno,uint256 _avail)public
    {
         map[own].bname.push(_bname);
         map[own].bno.push(_bno);
         map[own].avail.push(_avail);
         for(uint i=0;i<map[own].bno.length;i++)
         map1[_bno][own]=_avail;
    }
    
    function gets(string _sname,uint256 _rolno)public
    {
         mapp[_rolno].sname.push(_sname);
         mapp[_rolno].rolno.push(_rolno);
    }
    
     function takebook(uint256 _rolno,uint256 _bno)public  
    {
       
        map1[_bno][own]-=1;
        map2[_rolno][own]=_bno;
        mapp[_rolno].count +=1;
    
      }
     
     function Availability(uint _bno) public constant returns(uint)
     {
     
          return map1[_bno][own];
    }
   function stubook(uint256 _rolno)public constant returns(uint256 a)
   {
      return mapp[_rolno].count;
   }
    function bookreturn(uint _rolno,uint _bno)public
    {
     if(endtime>=t)
        {
            uint fine=1;
            uint d=now - endtime;
            uint t=d/60;
            uint c1=t * fine;
        }
        map1[_bno][own]+=1;
        mapp[_rolno].count -=1;
        }
}
