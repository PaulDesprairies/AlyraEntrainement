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
        partieA = _partieA;
        partieB = _partieB;
        etat = EtatCanal.VIDE;
    }
    
    function financer() payable public{
        require(msg.value == montant, "Montant incorrect");
        bool A;
        bool B;

        if(msg.sender == partieA){
            A = true;
            equilibreA += montant;
        }

        if(msg.sender == partieB){
            B = true;
            equilibreB += montant;
        }

        if(A == true && B == true){
            etat = EtatCanal.ACTIF;
        }
    }
    

    function message(uint virement) public returns (bytes32){

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
        return keccak256(abi.encodePacked(dernierNonce, equilibreA, equilibreB));
    }

}