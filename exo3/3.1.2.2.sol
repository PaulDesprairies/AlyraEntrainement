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
  if (msg.sender == membres[i]){
     return true;
  i += 1;
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

}