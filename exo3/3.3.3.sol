pragma solidity >=0.4.22 <0.6.0;

contract Pulsation {

    uint public battement;
    string private msg;
    
    constructor(string memory message) public{
        msg = message;
    }
    
    function ajouterBattement() public returns (string memory){
        battement +=1;
        return msg;
    }
}


contract Pendule is Pulsation("tic") {

address private id;
string[2] public battement;
uint8 public tictac;

Pulsation tac;
    
    function provoquerDesPulsations() public {
        tac.ajouterBattement();
    }
    
    function ajouterTac(Pulsation t, address adr) private{
        tac = t;
        id = adr;
    }
    
    function mouvementsBalancier() public{
		if (tictac == 1)
		{
			battement[tictac] = ajouterBattement();
			tictac = 0;
		}
		else
		{
			battement[tictac] = tac.ajouterBattement();
			tictac = 1;
		}
    }
}
