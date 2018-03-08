pragma solidity ^0.4.0;
contract lib{
    struct user{
        uint256 id;
        string name;
        string bookname;
        uint256 count;
        uint256[] showw;
    }
    struct book{
        uint256 bid;
        string  bname;
        uint256 bstock;
    }
    mapping(uint256 => user)users;
    mapping(uint256 => book)books;
    modifier check(uint256 id){
       require(books[id].bid==id);
        _;
    }
    function ruser(uint256 a,string name)public{
        users[a].id=a;
        users[a].name=name;
    }
    function rbook(uint256 bid,string name,uint256 stock)public{
        books[bid].bid=bid;
        books[bid].bname=name;
        books[bid].bstock=stock;
    }
  
    function bookchoose(uint256 bid,uint256 id)public  check(bid){
        require(books[bid].bstock>0);
        require(users[id].count <= 5);
            users[id].bookname= books[bid].bname;
            users[id].showw.push( books[bid].bid);
            users[id].count++;
            books[bid].bstock=books[bid].bstock-1;
    }
     function userchecking(uint256 id)public constant  returns(uint256,string,string,uint256){
        return( users[id].id,users[id].name,users[id].bookname,users[id].count);
    }
   function bookschecking(uint256 id)public constant check(id) returns(uint256,string,uint256){
        return( books[id].bid,books[id].bname,books[id].bstock);
    }
    
    function resultt(uint256 id)public constant returns(uint256[])
    {
        return (users[id].showw);
    }
    function bookreturn(uint256 bid,uint256 id)public{
            users[id].bookname= books[bid].bname;
            books[bid].bstock=books[bid].bstock+1;
            users[id].bookname="0";
            users[id].count--;
    }
}
