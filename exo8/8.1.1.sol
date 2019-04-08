pragma solidity ^0.5.6;


contract CanalDePaiement{
enum EtatCanal {VIDE, ACTIF, ENCOURSFERMETURE, FERME} 
address partieA;
address partieB;
uint montant;
EtatCanal etat;
uint blocFermeture; 
uint dernierNonce;
uint equilibreA;
uint equilibreB;

constructor(uint _montant, address _partieA, address _partieB) internal{
    montant = _montant;
    etat = EtatCanal.ACTIF;
    partieA = _partieA;
    partieB = _partieB;
}
}