pragma solidity >=0.4.22 <0.6.0;

contract Pulsation {

    uint public battement;
    string public msg;
    
    constructor(string memory message) public{
        msg = message;
    }
    
    function ajouterBattement() public returns (string memory){
        battement +=1;
        return "dong";
    }
}


contract Pendule is Pulsation("tic") {

address private id;
string[] public balancier;

Pulsation tac = new Pulsation("tac");



    function mouvementsBalancier(uint k) public{
		require(id != address(0), "Merci de renseigner une adresse en premier lieu.");
		uint i =0;
		while (i <= k){
		if (balancier.length % 2 == 0)
		{
			balancier.push(this.ajouterBattement());
		}
		else
		{
			balancier.push(tac.ajouterBattement());
		}
		i += 1;
		}
    }
}
