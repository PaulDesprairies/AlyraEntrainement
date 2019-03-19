pragma solidity 0.5.0;
pragma experimental ABIEncoderV2;

contract marketPlace{

    enum Satisfaction {MAUVAIS, CORRECT, BON, TRES_BON}
    struct Utilisateur{
        uint rep;
        string nom;
        string[] commentaires;
        Satisfaction[] satisfaction;
    }
    Utilisateur[] public utilisateurs;
    mapping (address => uint) indexUtilisateur;
    uint public nbUtilisateur;
    //
    enum Progess {OUVERTE,ENCOURS,FERMEE}
    struct Demande {
        string description;
        Progess etat;
        uint repMin;
        uint remuneration;
        address[] candidats;
        address illustrator;
        address emetteur;
        bytes32 hashUrl;
        uint acceptationDate;
        uint deliveryTime;
        uint deliveryDate;
    }
   
    Demande[] public demandes;
    mapping (address => uint) public indexDemande;
    uint public nbDemande;    
    
    ////////////////////Functions/////////////////////
    
    function getNbDemande() public view returns (Demande[] memory){
        return demandes;
    }

        
    function getNbCandidat(uint i) public view returns (address[] memory){
        return demandes[i].candidats;
    }
    
    
    function inscription(string memory nom) public{
        Utilisateur memory nouveau;
        nouveau.rep = 1;
        nouveau.nom = nom;
        utilisateurs.push(nouveau);
        indexUtilisateur[msg.sender] = nbUtilisateur;
        nbUtilisateur ++;
    }
    
    
    function postulerDemande (uint index) public{
        require(demandes[index].etat == marketPlace.Progess.OUVERTE,"Merci de postuler à une offre en cours.");
        require(utilisateurs[indexUtilisateur[msg.sender]].rep >= demandes[index].repMin, "Vous n'avez pas un niveau de réputation suffisant");
        demandes[index].candidats.push(msg.sender);
    }
    
    
    function enregistrerDemande(string memory description, uint timing, uint reputationMinimum, uint remuneration) public payable{
        
        //vérification de la disponibilité des fonds
        uint expectedAmount = remuneration + (remuneration * 2 / 100);
        uint valeur = msg.value;
        require(utilisateurs[indexUtilisateur[msg.sender]].rep>=1, "Vous devez vous inscrire sur la plateforme d'abord.");
    
        // append de demandes
        Demande memory nouvelleDemande;
        nouvelleDemande.description = description;
        nouvelleDemande.deliveryTime = timing;
        nouvelleDemande.repMin = reputationMinimum;
        nouvelleDemande.etat = marketPlace.Progess.OUVERTE;
        nouvelleDemande.remuneration = remuneration;
        //nouvelleDemande.illustrator = address(0);
        //nouvelleDemande.hashUrl = 0;
        nouvelleDemande.emetteur = msg.sender;
        //nouvelleDemande.candidats = rien
        demandes.push(nouvelleDemande);
        indexDemande[msg.sender] = nbDemande;
        nbDemande ++;
    }
    

    function accepterCandidat(uint indDemande, uint indCandidat) public returns(address){
        require(indexDemande[msg.sender] == indDemande, "Seul le demandeur peut choisir un illustrateur");
        require(indCandidat < demandes[indDemande].candidats.length, "Merci de sélectionner un candidat ayant postulé à cette demande.");
        demandes[indDemande].illustrator = demandes[indDemande].candidats[indCandidat];
        demandes[indDemande].etat = marketPlace.Progess.ENCOURS;
        demandes[indDemande].acceptationDate = block.timestamp;
        return demandes[indDemande].illustrator;
    }


    function livraisonIllustration(uint indDemande, bytes32 travaux) public payable{
        require(demandes[indDemande].illustrator == msg.sender, "Seul un illustrateur choisi par une entreprise peut remettre ses travaux");
        require(travaux != 0, "Vous devez remettre le hash de votre lien URL");
        require(demandes[indDemande].etat == marketPlace.Progess.ENCOURS, "Seul les projets en cours peuvent être assignés en retard");
        demandes[indDemande].hashUrl = travaux;
        demandes[indDemande].etat = marketPlace.Progess.FERMEE;
        demandes[indDemande].deliveryDate = block.timestamp;
        utilisateurs[indexUtilisateur[msg.sender]].rep += 1;    
        //msg.sender.transfer(demandes[indDemande].remuneration);
    }

    function refusIllutration(uint indDemande) public{
        require(indexDemande[msg.sender] == indDemande, "Seul le demandeur peut refuser une prestation");
        require(demandes[indDemande].etat == marketPlace.Progess.FERMEE, "Vous ne pouvez refuser une prestation non remise");
        demandes[indDemande].hashUrl = 0;
        demandes[indDemande].etat = marketPlace.Progess.ENCOURS;
        demandes[indDemande].deliveryDate = 0;
    }

    function retard(uint indDemande) public{
        require(indexDemande[msg.sender] == indDemande, "Seul le demandeur peut déclarer un retard de prestation");
        require(demandes[indDemande].etat == marketPlace.Progess.ENCOURS, "Seul les projets en cours peuvent être assignés en retard");
        uint delai = demandes[indDemande].acceptationDate + (demandes[indDemande].deliveryTime * 24 * 60 * 60);
        require(delai > block.timestamp, "Le projet ne peut être pénalisé pour retard tant qu'il est dans les temps");
        require(utilisateurs[indexUtilisateur[demandes[indDemande].illustrator]].rep > 1, "La réputation est déjà au minimum");
        utilisateurs[indexUtilisateur[demandes[indDemande].illustrator]].rep -= 1;
    }

    function commenterClient(uint indDemande, string memory comment, uint8 votre_note_sur_20) public{
        require(demandes[indDemande].illustrator == msg.sender, "Seul un illustrateur choisi par une entreprise peut commenter son client");
        uint delai = demandes[indDemande].deliveryDate + 2 weeks;
        require(delai <= block.timestamp, "Le projet ne peut être commenté que deux semaine après l'acceptation de l'illustration");
        require(votre_note_sur_20 < 21, "Merci de choisir une note entre 0 et 21");
        utilisateurs[indexUtilisateur[demandes[indDemande].emetteur]].commentaires.push(comment);

                ///attribution d'appréciation
        if (votre_note_sur_20 < 10){
            utilisateurs[indexUtilisateur[demandes[indDemande].emetteur]].satisfaction.push(marketPlace.Satisfaction.MAUVAIS);
            }
        else if(votre_note_sur_20 < 12){
            utilisateurs[indexUtilisateur[demandes[indDemande].emetteur]].satisfaction.push(marketPlace.Satisfaction.CORRECT);
            }
        else if(votre_note_sur_20 < 16){
            utilisateurs[indexUtilisateur[demandes[indDemande].emetteur]].satisfaction.push(marketPlace.Satisfaction.BON);
            }
        else{
            utilisateurs[indexUtilisateur[demandes[indDemande].emetteur]].satisfaction.push(marketPlace.Satisfaction.TRES_BON);
            }

        ///attribution de points de réputation

        if (utilisateurs[indexUtilisateur[demandes[indDemande].emetteur]].rep + votre_note_sur_20 - 10 > 0){
            utilisateurs[indexUtilisateur[demandes[indDemande].emetteur]].rep += votre_note_sur_20 - 10;
        }else{
            utilisateurs[indexUtilisateur[demandes[indDemande].emetteur]].rep = 1;  
        }
    }

    function commenterIllustrateur(uint indDemande, string memory comment, uint8 votre_note_sur_20) public{
        require(indexDemande[msg.sender] == indDemande, "Seul le demandeur peut commenter son illustrateur");
        uint delai = demandes[indDemande].deliveryDate + 2 weeks;
        require(delai <= block.timestamp, "Le projet ne peut être commenté que deux semaine après l'acceptation de l'illustration");
        require(votre_note_sur_20 < 21, "Merci de choisir une note entre 0 et 21");
        utilisateurs[indexUtilisateur[demandes[indDemande].illustrator]].commentaires.push(comment);

        ///attribution d'appréciation
        if (votre_note_sur_20 < 10){
            utilisateurs[indexUtilisateur[demandes[indDemande].illustrator]].satisfaction.push(marketPlace.Satisfaction.MAUVAIS);
            }
        else if(votre_note_sur_20 < 12){
            utilisateurs[indexUtilisateur[demandes[indDemande].illustrator]].satisfaction.push(marketPlace.Satisfaction.CORRECT);
            }
        else if(votre_note_sur_20 < 16){
            utilisateurs[indexUtilisateur[demandes[indDemande].illustrator]].satisfaction.push(marketPlace.Satisfaction.BON);
            }
        else {
            utilisateurs[indexUtilisateur[demandes[indDemande].illustrator]].satisfaction.push(marketPlace.Satisfaction.TRES_BON);
            }

        ///attribution de points de réputation

        if (utilisateurs[indexUtilisateur[demandes[indDemande].illustrator]].rep + votre_note_sur_20 - 10 > 0){
            utilisateurs[indexUtilisateur[demandes[indDemande].illustrator]].rep += votre_note_sur_20 - 10;
        }else{
            utilisateurs[indexUtilisateur[demandes[indDemande].illustrator]].rep = 1;  
        }
    }
}
