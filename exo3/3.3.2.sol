pragma solidity >=0.4.22 <0.6.0;


contract Pulsation {

    uint public battement;
    string private msg;
    
    constructor(string memory message) public{
        battement = 0;
        msg = message;
    }
    
    function ajouterBattement() public returns (string memory){
        battement +=1;
        return msg;
    }
}

contract Pendule {

Pulsation pulse;
    
    function provoquerDesPulsations() public {
        pulse.ajouterBattement();
    }
}
