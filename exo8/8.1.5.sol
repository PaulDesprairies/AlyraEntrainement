pragma solidity ^0.5.6;
import "http://github.com/OpenZeppelin/openzeppelin-solidity/contracts/cryptography/ECDSA.sol";

contract CanalDePaiement{
    using ECDSA for bytes32;
    enum EtatCanal {VIDE, ACTIF, ENCOURSFERMETURE, FERME} 
    address payable partieA;
    address payable partieB;
    uint montant;
    EtatCanal etat;
    uint blocFermeture; 
    uint dernierNonce;
    uint equilibreA;
    uint equilibreB;
    uint contestation = 24;


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


    function fermeture(uint _nonce, uint _equilibreA, uint _equilibreB, bytes memory _signature) public {
        require(msg.sender == partieA || msg.sender == partieB, "Vous n'avez pas le droit de fermer ce canal");
        require(etat != EtatCanal.FERME && etat != EtatCanal.VIDE, "Ceci est une fondtion de fermeture");
       if (etat == EtatCanal.ACTIF){
            blocFermeture = block.number;
            etat = EtatCanal.ENCOURSFERMETURE;
        }
        if (etat == EtatCanal.ENCOURSFERMETURE){
            require(block.number >= blocFermeture + contestation,"Temps de contestation terminé");
        }
        
        
        
        bytes32 hash = message(_nonce, _equilibreA, _equilibreB);
        address signer = hash.recover(_signature);
        require(signer == partieA || signer == partieB, "La signature n'est pas la bonne");
        
        if (dernierNonce < _nonce){
            dernierNonce = _nonce;
            equilibreA = _equilibreA;
            equilibreB = _equilibreB;
        }
        

    }

    
    function solde() payable public{
        require(msg.sender == partieA || msg.sender == partieB, "Vous n'avez pas le droit de demander le solde de ce canal");
        require(etat == EtatCanal.ENCOURSFERMETURE, "Il vous faut d'abord fermer le canal");
        require(block.number >= blocFermeture + contestation, "Veuillez attendre n blocs en temps de contestation");
        partieA.transfer(equilibreA);
        partieB.transfer(equilibreB);

    }

}