//Write your own contracts here. Currently compiles using solc v0.4.15+commit.bbb8e64f.

pragma solidity 0.4.25;
contract Assemblee {
  address[] membres; 
  string[] descriptionDecisions;
  uint[] public voteContre;
  uint[] public votePour;


function rejoindre() public{
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

function proposerDecision(string description) public{
  if (estMembre(msg.sender)){
    descriptionDecisions.push(description);
    votePour.push(0);
    voteContre.push(0);
  }
}

function voter(string description, uint vote) public view returns (bool){
  if (estMembre(msg.sender)){
    for (uint i=0; i < descriptionDecisions.length; i++)
    //could not compare pure strings here, so hashin them, assuming that the keccak256 function (sha3) is injective.
      if (keccak256(description) == keccak256(descriptionDecisions[i])){
        if (vote == 1){
          votePour[i] +=1;
        }else if (vote == 0){
          voteContre[i] +=1;
        }else{
          //voter(description, vote);
        }
    }else{
      //proposerDecision(description);
      //voter(description, vote);
    }
  }
}

function comptabiliser(uint indice) public view returns (int){
  return int(votePour[indice])-int(voteContre[indice]);
}
}