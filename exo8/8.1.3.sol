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

    constructor(uint _montant, address _partieA, address _partieB) public{
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

    

    function virer(uint virement) public returns (bytes32){

        if (msg.sender == partieA){
            require(equilibreA >= virement, "Vous n'avez pas les fonds suffisants");
            equilibreA -= virement;
            equilibreB += virement;
            dernierNonce += 1;
        }

        else if (msg.sender == partieB){
            require(equilibreB >= virement, "Vous n'avez pas les fonds suffisants");
            equilibreA += virement;
            equilibreB -= virement;
            dernierNonce += 1;
        }
        return message(dernierNonce, equilibreA, equilibreB);
    }

    function message(uint a, uint b, uint c) pure public returns(bytes32){
      return keccak256(abi.encodePacked(a,b,c)); 
    }

}