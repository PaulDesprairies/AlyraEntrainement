//Write your own contracts here. Currently compiles using solc v0.4.15+commit.bbb8e64f.

pragma solidity 0.4.25;
contract Assemblee {
  address[] membres; 

struct Decision{
  string[] descriptionDecisions;
  uint[] voteContre;
  uint[] votePour;
  uint[] timeStamp;
  mapping( address => bool) aVote;
}



Decision[4] decisions;

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
  if (estMembre(msg.sender)){
    decisions[0].descriptionDecisions.push(description);
    decisions[1].votePour.push(0);
    decisions[2].voteContre.push(0);
    decisions[3].timeStamp.push(now);
  }
}

function voter(string description, uint vote) public view returns (bool){
  require(estMembre(msg.sender), "Il faut être membre !");
    uint8 dec = 0;
    for (uint i=0; i < decisionLenght(); i++){
      if (keccak256(abi.encode(decisions[i].descriptionDecisions)) == keccak256(abi.encode(decisions[i].descriptionDecisions[i]))){
        require(now - decisions[i].timeStamp[i] < 604800 ); //erreur ici
        require((decisions[i].aVote[msg.sender]==false), "Vous avez déjà voté !");
        require(vote == 1 || vote == 0, "Il faut voter 1 pour oui ou 0 pour non.");
        if (vote == 1){
          decisions[i].votePour[i] +=1;
        }else if (vote == 0){
          decisions[i].voteContre[i] +=1;
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
  return int(decisions[indice].votePour[indice])-int(decisions[indice].voteContre[indice]);
}
}