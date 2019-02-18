//Write your own contracts here. Currently compiles using solc v0.4.15+commit.bbb8e64f.

pragma solidity 0.4.25;
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

constructor(string nom) public{
    nomAssemble = nom;
}

function decisionLenght() public constant returns(uint) {
    return decisions.length;
}

function rejoindre() public{
  membres.push(msg.sender);
}

function estMembre(address utilisateur) public view returns (bool){
 for (uint i=0; i<membres.length; i++) {
  if (msg.sender == membres[i]){
     return true;
  i += 1;
   }
  return false;
 }
}

function proposerDecision(string description) public{
  require(estMembre(msg.sender), "Il faut être membre !");
  Decision memory nouvelleDecision;
    nouvelleDecision.descriptionDecisions = description;
    nouvelleDecision.votePour = 0;
    nouvelleDecision.voteContre = 0;
    nouvelleDecision.timeStamp = now;
    decisions.push(nouvelleDecision);
  }

function voter(string description, uint vote) public view returns (bool){
  require(estMembre(msg.sender), "Il faut être membre !");
    uint8 dec = 0;
    for (uint i=0; i < decisionLenght(); i++){
      if (keccak256(abi.encode(decisions[i].descriptionDecisions)) == keccak256(abi.encode(decisions[i].descriptionDecisions))){
        require(now - decisions[i].timeStamp < 604800, "Vous votez trop tard sur cette décision" );
        require((decisions[i].aVote[msg.sender]==false), "Vous avez déjà voté !");
        require(vote == 1 || vote == 0, "Il faut voter 1 pour oui ou 0 pour non.");
        
        if (vote == 1){
          decisions[i].votePour += 1;
        }else if (vote == 0){
          decisions[i].voteContre += 1;
        }

      decisions[i].aVote[msg.sender] = true;
      dec = 1;
    }
    if (dec == 0) {
      revert("Il faut d'abord soumettre une décision !");
    } 

  }
}

function comptabiliser(uint indice) public view returns (int){
  return int(decisions[indice].votePour)-int(decisions[indice].voteContre);
}
}