pragma solidity 0.5.0;
pragma experimental ABIEncoderV2;

contract marketPlace{
    
    struct Utilisateur{
        uint rep;
        string nom;
    }
    mapping (address => Utilisateur) user;
    address[] public utilisateurs;
    //
    enum Progess {OUVERTE,ENCOURS,FERMEE}
    Progess public etat;
    struct Demande {
        uint timing;
        string description;
        Progess etat;
        uint repMin;
        uint remuneration;
        address[] candidats;
    }
    mapping (address => Demande) registration;
    address[] public demandes;
    //demande(index)--> js
    
    
    //https://coursetro.com/posts/code/102/Solidity-Mappings-&-Structs-Tutorial//

    ////////////////////Functions/////////////////////
    
    function inscription(string memory nom) public{
        require(user[msg.sender].rep == 0,"Utilisateur déjà renseigné");
        Utilisateur memory nouveau = user[msg.sender];
        nouveau.rep = 1;
        nouveau.nom = nom;
        utilisateurs.push(msg.sender);
    }
    
    
    //////////////////
    
    function filtrerCandidats(uint reputationMinimum) public view returns (address[] memory){
        address[] memory candidats = new address[](utilisateurs.length);
        for (uint i = 0; i < utilisateurs.length; i++){
            if (user[utilisateurs[i]].rep >= reputationMinimum){
                candidats[i] = utilisateurs[i];
            }else{
                delete candidats[i];
            }
        }
        return candidats;
    }
    
    
    //////////////////
    
    
    function enregistrerDemande(string memory description, uint timing, uint reputationMinimum, uint remuneration) public payable{
        
        //vérification de la disponibilité des fonds
        uint expectedAmount = remuneration + (remuneration * 2 / 100);
        require(msg.value == expectedAmount, "Veuillez attacher votre offre en wei + 2% à votre transaction");

        // append de demandes
        Demande memory nouvelleDemande = registration[msg.sender];
        nouvelleDemande.description = description;
        nouvelleDemande.timing = timing;
        nouvelleDemande.repMin = reputationMinimum;
        nouvelleDemande.etat = marketPlace.Progess.OUVERTE;
        nouvelleDemande.candidats = filtrerCandidats(reputationMinimum);
        demandes.push(msg.sender);
    }
    
}