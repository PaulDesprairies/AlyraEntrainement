//Write your own contracts here. Currently compiles using solc v0.4.15+commit.bbb8e64f.

pragma solidity 0.5.1;
contract Assemblee {
  
  string public nomAssemble;
  address[] membres; 

  struct Decision{
    string descriptionDecisions;
    uint voteContre;
    uint votePour;
    uint timeStamp;
    mapping( address => bool) aVote;
  }

Decision[] decisions;

constructor(string memory nom) public{
    nomAssemble = nom;
}

function rejoindre() public payable{
  membres.push(msg.sender);
}

function estMembre(address utilisateur) public view returns (bool){
 for (uint i=0; i<membres.length; i++) {
  if (utilisateur == membres[i]){
     return true;
   }
  return false;
 }
}

function proposerDecision(string memory description) payable public{
  require(estMembre(msg.sender), "Il faut être membre !");
  Decision memory nouvelleDecision;
    nouvelleDecision.descriptionDecisions = description;
    nouvelleDecision.votePour = 0;
    nouvelleDecision.voteContre = 0;
    nouvelleDecision.timeStamp = block.timestamp;
    decisions.push(nouvelleDecision);
  }

function voter(uint i, uint vote) public payable returns (bool){
    require(estMembre(msg.sender), "Il faut être membre !");
    require(block.timestamp - decisions[i].timeStamp < 604800, "Vous votez trop tard sur cette décision" );
    require((decisions[i].aVote[msg.sender] == false), "Vous avez déjà voté !");
    require(vote == 1 || vote == 0, "Il faut voter 1 pour oui ou 0 pour non.");
        
    if (vote == 1){
      decisions[i].votePour += 1;
    }else if (vote == 0){
      decisions[i].voteContre += 1;
    }
     decisions[i].aVote[msg.sender] = true;
}

function comptabiliser(uint indice) public view returns (int){
  return int(decisions[indice].votePour)-int(decisions[indice].voteContre);
}
}