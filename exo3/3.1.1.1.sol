//Write your own contracts here. Currently compiles using solc v0.4.15+commit.bbb8e64f.
pragma solidity 0.4.25;



contract SceneOuverte {

string[12] passagesArtistes;
uint creneauxLibres = 12;
uint tour;
uint fin;
string output;

function sInscrire(string nomArtiste) public {
    if (creneauxLibres > 0){
        passagesArtistes[12 - creneauxLibres] = nomArtiste;
        creneauxLibres -= 1;
    }
  }

function passerArtisteSuivant() public{
  if (tour < 12 - creneauxLibres){
      tour +=1;
  }
}

function artisteEnCours() public constant returns (string){
  if (tour == 12 - creneauxLibres){
    fin = 1;
  }
  if (fin==1){
    output = "Fin";
  }else{
    output = passagesArtistes[tour-1];
  } 
  return output;
}
}