pragma solidity ^0.5.6;


contract CanalDePaiement{
    enum EtatCanal {VIDE, ACTIF, ENCOURSFERMETURE, FERME} 
    address payable partieA;
    address payable partieB;
    uint montant;
    EtatCanal etat;
    uint blocFermeture; 
    uint dernierNonce;
    uint equilibreA;
    uint equilibreB;

    constructor(uint _montant, address payable _partieA, address payable _partieB) public{
        montant = _montant;
        partieA = _partieA;
        partieB = _partieB;
        etat = EtatCanal.VIDE;
    }
    
    function financer() payable public returns (EtatCanal){
        require(msg.value == montant, "Montant incorrect");
        if(msg.sender == partieA ){
            require(equilibreA == 0,"Montant déjà versé");
            equilibreA += montant;
        }
        if(msg.sender == partieB ){
            require(equilibreB == 0,"Montant déjà versé");
            equilibreB += montant;
        }
        if(equilibreA == montant && equilibreB == montant){
            etat = EtatCanal.ACTIF;
        }
        
        return etat;
    }

    
    function message(uint _dernierNonce, uint _equilibreA, uint _equilibreB) pure public returns(bytes32){
      return keccak256(abi.encodePacked(_dernierNonce, _equilibreA, _equilibreB)); 
    }
}