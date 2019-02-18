//Write your own contracts here. Currently compiles using solc v0.4.15+commit.bbb8e64f.

pragma solidity 0.4.25;
contract Assemblee {
  
  string public nomAssemble;


  struct Habilitation{
    address membres;
    mapping( address => bool) estAdmin;
    uint8 blame;
  } 

  struct Decision{
    string descriptionDecisions;
    uint voteContre;
    uint votePour;
    uint timeStamp;
    mapping( address => bool) aVote;
  }

Habilitation[] habilitations;
Decision[] decisions;


//initialisation du contrat, premier admin, nommage de l'assemblée
constructor(string nom) public {
    nomAssemble = nom;
    habilitations[0].membres = msg.sender;
    habilitations[0].estAdmin[msg.sender] = true;
    habilitations[0].blame = 0;
}


//rejoindre l'assemblée
function rejoindre() public {
  require((estMembre(msg.sender) >= 0), "Vous êtes déjà membre !");
  Habilitation memory welcome;
  welcome.membres = msg.sender;
  welcome.blame = 0;
  habilitations.push(welcome);
}


//Vérifie si une personne est déjà membre ou non et renvoit un index si la décision existe
function estMembre(address utilisateur) public view returns (uint) {
 for (uint i=0; i < habilitations.length-1; i++) {
  if (msg.sender == habilitations[i].membres){
     return i;
   }
  i += 1;
  }
}


//Soumettre une décision
function proposerDecision(string description) public {
  require(estMembre(msg.sender) >= 0, "Il faut être membre !");
  Decision memory nouvelleDecision;
    nouvelleDecision.descriptionDecisions = description;
    nouvelleDecision.votePour = 0;
    nouvelleDecision.voteContre = 0;
    nouvelleDecision.timeStamp = now;
    decisions.push(nouvelleDecision);
  }


//Vérifie si la décision est déjà soumise ou non et renvoit un index si la décision existe
function decisionRedondante(string decision) public view returns (uint) {
 for (uint i=0; i < decisions.length-1; i++) {
  if (keccak256(decision) == keccak256(decisions[i].descriptionDecisions)) {
     return i;
   }
  i += 1;
  }
}

//Voter une décision sur un délai de 7 jours en comptabilisant les résultats à chaque vote
function voter(string description, uint vote) public view returns (bool) {
    require(estMembre(msg.sender) >= 0, "Il faut être membre !");
    require(decisionRedondante(description) >= 0, "Vous avez déjà proposé cette décision !");
    require(now - decisions[i].timeStamp < 604800, "Vous votez trop tard sur cette décision" );
    require((decisions[i].aVote[msg.sender]==false), "Vous avez déjà voté !");
    require(vote == 1 || vote == 0, "Il faut voter 1 pour oui ou 0 pour non.");
    uint i = decisionRedondante(description);

      if (vote == 1){
        decisions[i].votePour += 1;
      }else if (vote == 0){
        decisions[i].voteContre += 1;
      }

      decisions[i].aVote[msg.sender] = true;
      comptabiliser(i);
    }


//Comptabilisation des votes
function comptabiliser(uint indice) public view returns (int) {
  return int(decisions[indice].votePour)-int(decisions[indice].voteContre);
}

// Nommer un administrateur
function nommerAdmin(address promu) public view {
  require(habilitations[estMembre(promu)].estAdmin[msg.sender], "Il faut être administrateur pour effectuer cette action.");
  require(estMembre(promu) >= 0);
  habilitations[estMembre(promu)].estAdmin[promu] = true;
}

//Démission d'un administrateur
function demission() public view {
  require(habilitations[estMembre(msg.sender)].estAdmin[msg.sender], "Il faut être administrateur pour effectuer cette action.");
  habilitations[estMembre(msg.sender)].estAdmin[msg.sender] = false;
}

//Fermer proposition de décision
function veto(string description) public view {
  require(habilitations[estMembre(msg.sender)].estAdmin[msg.sender], "Il faut être administrateur pour effectuer cette action.");
  delete decisions[decisionRedondante(description)];
}

//Attribuer un blame et expulser au second blame
function blamer(address puni) public view {
  require(habilitations[estMembre(msg.sender)].estAdmin[msg.sender], "Il faut être administrateur pour effectuer cette action.");
  require(estMembre(puni)>=0, "Vous ne pouvez attribuer un blâme à un non-membre.");
  habilitations[estMembre(puni)].blame =+ 1;

  if (habilitations[estMembre(puni)].blame == 2){
    delete habilitations[estMembre(puni)];
  }

}
}