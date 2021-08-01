//Create Crypto Bank Contract

//    1 The owner can start the bank with initial deposit/capital in ether min 50 eths
//    2 Only the owner can close the bank. Upon closing the balance should return to the Owner
//    3 Anyone can open an account in the bank for Account opening they need to deposit ether with address
//    4 Bank will maintain balances of accounts
//    5 Anyone can deposit in the bank
//    6 Only valid account holders can withdraw
//    7 First 5 accounts will get a bonus of 1 ether in bonus
//    8 Account holder can inquiry balance
//The depositor can request for closing an account


//SPDX-License-Identifier:MIT
pragma solidity ^0.8.4;

contract Createbankaccount {
    address owner;
    function opening () payable public {
        owner = msg.sender;
        require (msg.value >= 50 ether, "You are not an owner");
    }
    function closing () external payable {
        selfdestruct (payable(owner));
        
    }
    mapping (address => uint) private customeraccount;
    function newcustomer () public payable {
        require (msg.sender != address(0) && msg.value > 0 ether, "please provide correct address and value");
        customeraccount [msg.sender]=(msg.value);
        if (count <= 4) {
            customeraccount [msg.sender] += 1 ether;
            count ++;
        }
    }
    function deposit (address _to, uint _value) payable public {
        customeraccount [_to] += _value;
    }
    function withdraw (address _from, uint _amount) public payable {
        customeraccount [_from] -= _amount;
        require (msg.sender == _from && msg.value != (uint(0)));
        payable (msg.sender).transfer(_amount);
        customeraccount [msg.sender] -= _amount;
    }
    uint count;
    function balanceinquiry (address) public view returns (uint){
        return customeraccount[msg.sender];
    }
    function closingcustomeraccount (address) public {
        selfdestruct (payable(msg.sender));
    }
}