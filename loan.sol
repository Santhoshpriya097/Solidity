pragma solidity ^0.4.0;

contract Register
{
    struct bank_Details
    {
        string name;
        uint256 bal;
        uint256 time;
        uint256 loan_interst;
    }
    
    mapping(address=>bank_Details) public bank_d1;
    //mapping(uint=>address) public reg_user;
    address[] public reg_user;
    
  
    function show_registers() public view returns(address[])
    {
        return reg_user;
    }
    function show_bank_detail(uint index,uint intr_type)public view returns(string bank_name,address tem_add,uint intr)
    {
        tem_add=reg_user[index];
        bank_name=bank_d1[tem_add].name;
        if(intr_type==0)
        {
            intr=bank_d1[tem_add].loan_interst;
        }
    }
}

contract FinancialInst is Register
{
    modifier ch_register()
    {
        require(bank_d1[msg.sender].time !=0);
        _;
    }
   
   
    function withdraw() ch_register public payable
    {
        require(bank_d1[msg.sender].bal>msg.value);
        bank_d1[msg.sender].bal-=msg.value;
        
        address me=msg.sender;
        me.transfer(msg.value);
    }
   
    function transfer(address to) ch_register public payable
    {  
        require(bank_d1[msg.sender].bal>msg.value);
        bank_d1[to].bal+=msg.value;
        bank_d1[msg.sender].bal-=msg.value;
        //to.transfer(msg.value);
    }
    
    function GetBalance() ch_register public constant returns (uint256)
    {
        return bank_d1[msg.sender].bal;
    }

    function fetchBalance(address _banker) public constant returns (uint256)
    {
        return bank_d1[_banker].bal;
    }

    function isRegistered(address _bank) public constant returns (bool) {
      return bank_d1[_bank].time > 0;
    }
}

contract Financial is FinancialInst
{
   // uint eth=1 ether;
    uint256 total_token_value;
    uint256[] total_token;
    //uint256 public ln_req_count=0;
    struct loan_get
    {
        address bank_address;
        uint256 amount;
        uint256 count;
        uint last_setl_time;
        uint time;
        uint months;
        uint bal_ln;
        uint installment;
        uint256 id;
        uint256 token;
    }
    
     function Financial(string name,uint _loan_interst,uint256 _time) public payable{
        bank_d1[msg.sender].name=name;
        bank_d1[msg.sender].loan_interst=_loan_interst;
        bank_d1[msg.sender].bal=msg.value;
        bank_d1[msg.sender].time=_time;
        reg_user.push(msg.sender);
    }
    
    mapping (address=>mapping(uint256=>loan_get))public ln_get;
    mapping(address=>uint256)public ln_get_count;
    
    struct loan_pro
    {
        address bank_address;
        uint256 amount;
        uint time;
        uint months;
    }
    
     address public spv_add;
     address public investor_add;
     struct spv_detail
        {
            
            uint256 initial_spv_ether;
            uint256 spv_loan;
            uint256 spv_send_ether;
            uint256 available_pack;
            uint256 send_pack;
        }
    
     struct Investor
        {
            uint256 Investor_ether;
            uint256 Investor_package;
        }
    mapping (address=>mapping(uint256=>loan_pro))public ln_pro;
    mapping(address=>uint256)public ln_pro_count;
    
     mapping(address=>spv_detail)public spv_details;
     mapping(address=>Investor)public investor_details;
    
    function req_loan(address bank_address,uint256 tokenvalue) public payable
    {   
        uint256 amt = (tokenvalue * 80 / 100);

        //require(bank_d1[msg.sender].time!=0);
        require(bank_d1[bank_address].time!=0);
        require(bank_address!=msg.sender);
        
        require (bank_d1[bank_address].bal > amt );
            
        //bank_d1[msg.sender].bal += amt*eth;
        bank_d1[bank_address].bal -= amt;
        
        
        
        ln_get[msg.sender][ln_get_count[msg.sender]].bank_address = bank_address;
        ln_get[msg.sender][ln_get_count[msg.sender]].amount = amt;
        ln_get[msg.sender][ln_get_count[msg.sender]].months=12;
        ln_get[msg.sender][ln_get_count[msg.sender]].time=now;
        ln_get[msg.sender][ln_get_count[msg.sender]].last_setl_time=now;
        ln_get[msg.sender][ln_get_count[msg.sender]].installment=(amt)/(12);
        ln_get[msg.sender][ln_get_count[msg.sender]].bal_ln = amt;
        ln_get[msg.sender][ln_get_count[msg.sender]].id = ln_get_count[msg.sender];
        ln_get[msg.sender][ln_get_count[msg.sender]].token = tokenvalue ;
        
         total_token_value += tokenvalue;
         total_token.push(ln_get[msg.sender][ln_get_count[msg.sender]].token);
        
        ln_pro[bank_address][ln_pro_count[bank_address]].bank_address = msg.sender;
        ln_pro[bank_address][ln_pro_count[bank_address]].amount = amt;
        ln_pro[bank_address][ln_pro_count[bank_address]].months=12;
        ln_pro[bank_address][ln_pro_count[bank_address]].time=now;
        
        ln_pro_count[bank_address]++;
        ln_get_count[msg.sender]++;

        msg.sender.transfer(amt * 1 wei);
    }
    
    function settlement(uint ln_id) public
    {
        uint temp_count=ln_get[msg.sender][ln_id].count;
        uint temp_month=ln_get[msg.sender][ln_id].months;
        uint temp_bal_ln=ln_get[msg.sender][ln_id].bal_ln;
        uint temp_ins=ln_get[msg.sender][ln_id].installment;
        uint temp_last=ln_get[msg.sender][ln_id].last_setl_time + 1 minutes;//30 days;
        address temp_bank_address=ln_get[msg.sender][ln_id].bank_address;
        
        require(temp_count<temp_month);
       // require((temp_last + 1 minutes)<=now);
        
        uint intr=bank_d1[temp_bank_address].loan_interst;
        uint amont=( temp_bal_ln * (intr/100) ) /100;
        
        //require(amont+temp_ins<=bank_d1[msg.sender].bal);
        
        //bank_d1[msg.sender].bal -= amont+temp_ins;
        bank_d1[temp_bank_address].bal += amont+temp_ins;
        
        ln_get[msg.sender][ln_id].last_setl_time = temp_last +1 minutes;//30 days;
        ln_get[msg.sender][ln_id].bal_ln-=temp_ins;
        ln_get[msg.sender][ln_id].count++;

        //temp_bank_address.transfer(amont * 1 wei);
        
        
         if(spv_details[spv_add].spv_loan > 0)
        {
        uint256 bank_take_interest=(amont *10)/100;
        bank_d1[reg_user[0]].bal +=bank_take_interest;
        
        uint256 spv_take_interest=((amont-bank_take_interest)*10)/100;
        spv_details[spv_add].initial_spv_ether +=spv_take_interest;
        
        if(total_token.length /1 !=0)
        {
        uint256 balance_investor_amount=amont- (bank_take_interest+spv_take_interest);
        investor_details[investor_add].Investor_ether += balance_investor_amount;
        }
        }
        
        else
        {
             bank_d1[temp_bank_address].bal += amont;
        }
    }
    function SPV_ether()public payable
        {
         spv_add = msg.sender;
         spv_details[spv_add].initial_spv_ether=msg.value;
         
        }
    
     function sell_loan()public payable
        {
       // spv_details[spv_add].spv_loan = total_token;
         spv_details[spv_add].spv_loan=total_token_value;
         spv_details[spv_add].spv_send_ether = spv_details[spv_add].spv_loan;
         bank_d1[reg_user[0]].bal += spv_details[spv_add].spv_send_ether;
         spv_details[spv_add].initial_spv_ether -= spv_details[spv_add].spv_send_ether;
        }
    function Investor_ether()public payable
        {
         investor_add = msg.sender;
         investor_details[investor_add].Investor_ether=msg.value;
         
        }
        function avail_pack()public
        {
            spv_details[spv_add].available_pack = total_token.length / 1;
        }
        
        function send_package(uint256 pack)public
        {
            spv_details[spv_add].send_pack += pack;
            spv_details[spv_add].available_pack -= pack;
            spv_details[spv_add].spv_loan -= pack * 3;
            investor_details[investor_add].Investor_package += pack;
            investor_details[investor_add].Investor_ether -= (pack * 3) * 10 ;
            spv_details[spv_add].initial_spv_ether += (pack * 3) * 10 ;
            
        }
}
