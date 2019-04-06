pragma solidity ^0.5.6;
pragma experimental ABIEncoderV2;


contract JeuDesCivilisations {

    enum Identity {SAGE, AGRESSIF, RECLU, IMPREVISIBLE} //Genesis - Identité

    struct Civilisation {
        address founder;
        address roi;
        string name;
        uint age; //(de 0 à 3)
        Identity identity;
        uint8 divinity_type; //(de 0 à 4)
        uint8 divinity_level; //(de 0 à 3)
        uint8 element_type; //(de 0 à 4)
        uint8 element_level; //(de 0 à 3)
        uint8 technology_type; //(de 0 à 4)
        uint8 technology_level; //(de 0 à 3)

        uint sesterces;
        bytes32 signature;
        uint8 merveille;
        bool remparts;
    }

    Civilisation[] civilisations;
    mapping (bytes32 => uint) private _civilisationIndex;
    uint nbCivilisation = 1;

    struct Player {
        string name;
        address identity;
        bytes32 originCivilisation;
        bytes32[7] ownedCivilisations;
        uint last_action;
    }

    Player[] players;
    mapping(address => uint) _playerIndex;
    uint nbJoueurs = 1;

////****Initialisation********////
constructor() public {
        Player memory nouveauJoueur;
        Civilisation memory nouvelleCivilisation;
    
           //Nouveau joueur
        nouveauJoueur.name = "Constructeur";
        nouveauJoueur.identity = address(this);
        nouveauJoueur.last_action = block.number;

        //Nouvelle civilisation
        nouvelleCivilisation.signature = 0;
        nouvelleCivilisation.name = "Genesis";
        nouvelleCivilisation.roi = address(this);
        nouvelleCivilisation.founder = address(this);
 

        players.push(nouveauJoueur);
        civilisations.push(nouvelleCivilisation);
}



///**************Fondation*************//
    function fonderCivilisation(string memory _namePlayer, string memory _nameCivilisation, uint8 divinity_type, uint8 element_type, uint8 technology_type) public payable returns (bytes32){

        require(divinity_type<5 && element_type < 5 && technology_type <5, "Veuillez choisir les directions de votre civilisation");
        require(msg.value == 0.1 ether, "Une fondation coûte 0.1 ether");
        bytes32 signature = blockhash(block.number-1);
        require(_civilisationIndex[signature] == 0, "Cette civilisation a déjà été fondée");

        Player memory nouveauJoueur;
        Civilisation memory nouvelleCivilisation;

        //Nouveau joueur
        nouveauJoueur.name = _namePlayer;
        nouveauJoueur.identity = msg.sender;
        nouveauJoueur.originCivilisation = signature;
        nouveauJoueur.ownedCivilisations[0] = signature;
        nouveauJoueur.last_action = block.number;
        _playerIndex[msg.sender] = nbJoueurs;
        nbJoueurs++;

        //Nouvelle civilisation
        nouvelleCivilisation.signature = signature;
        nouvelleCivilisation.name = _nameCivilisation;
        nouvelleCivilisation.technology_type = technology_type;
        nouvelleCivilisation.element_type = element_type;
        nouvelleCivilisation.divinity_type = divinity_type;
        nouvelleCivilisation.identity = JeuDesCivilisations.Identity(generateRandom(4));
        nouvelleCivilisation.roi = msg.sender;
        nouvelleCivilisation.founder = msg.sender;
        nouvelleCivilisation.sesterces = 1000;
        _civilisationIndex[signature] = nbCivilisation;
        nbCivilisation++;

        players.push(nouveauJoueur);
        civilisations.push(nouvelleCivilisation);

        return signature;
    }



    
    //*************Informations**************//
    
    ///Génère un chiffre random de 1 à param
    function generateRandom(uint param) private view returns (uint) {
        return(uint(blockhash(block.number-1))%param) + 1;
    }

    function voiciMonRoyaume(address roi) public view returns (bytes32[7] memory){
        bytes32[7] memory royaume = players[_playerIndex[roi]].ownedCivilisations;
        require(royaume.length != 0, "Vous êtes un imposteur");
        return royaume;
    }

    function voiciMonRoi(bytes32 civilisationID) public view returns (address) {
        address roi = civilisations[_civilisationIndex[civilisationID]].roi;
        require(roi != address(0));
        return roi;
    }

    function civilisationExiste(bytes32 civilisationID) public view returns (bool) {
        return _civilisationIndex[civilisationID] != 0;
    }

    function presenterCivilisation(bytes32 civilisationID) public view returns (Civilisation memory) {
        require(civilisationExiste(civilisationID), "Cette civilisation n'existe pas");
        return civilisations[_civilisationIndex[civilisationID]];
    }

    function changementDAllegence(address vainqueur, bytes32 civilisationID) internal{
        require(vainqueur != address(0));

        address roiDechu = voiciMonRoi(civilisationID);
        uint etendueRoyaume = players[_playerIndex[vainqueur]].ownedCivilisations.length;
        players[_playerIndex[vainqueur]].ownedCivilisations[etendueRoyaume] = civilisationID;

        for (uint i = 0; i < voiciMonRoyaume(roiDechu).length; i++){
            if(voiciMonRoyaume(roiDechu)[i] == civilisationID){
                delete voiciMonRoyaume(roiDechu)[i];
            }
        }
        civilisations[_civilisationIndex[civilisationID]].roi = vainqueur;
        if (players[_playerIndex[roiDechu]].ownedCivilisations.length == 0){
            exil(roiDechu);
        }

    }

    function civilisationRichesse(bytes32 civilisationID, uint sesterces) internal view returns (bool){
        require(civilisationExiste(civilisationID), "Cette civilisation n'existe pas");
        return civilisations[_civilisationIndex[civilisationID]].sesterces >= sesterces;
    }

    function civilisationOriginelle(address roi) internal view returns (bytes32){
        return players[_playerIndex[roi]].originCivilisation;
    }

    //Paiement d'une rançon proportionnelle à l'age de la civilisation
    function paiementRancon(bytes32 civilisationID1, bytes32 civilisationID2, uint sesterces) internal{
        require(civilisationExiste(civilisationID1), "Cette civilisation1 n'existe pas");
        require(civilisationExiste(civilisationID2), "Cette civilisation2 n'existe pas");
        civilisations[_civilisationIndex[civilisationID1]].sesterces += sesterces;
        civilisations[_civilisationIndex[civilisationID2]].sesterces -= sesterces;
    }

    //Montée en compétence
    function monteeEnCompetence(bytes32 civilisationID, uint up) internal{
        if (up == 1){
            require(civilisations[_civilisationIndex[civilisationID]].technology_level<3, "Vous êtes déjà au niveau trois de la technology");
            civilisations[_civilisationIndex[civilisationID]].divinity_level ++;
        }else if(up == 2){
            require(civilisations[_civilisationIndex[civilisationID]].technology_level<3, "Vous êtes déjà au niveau trois de la technology");
            civilisations[_civilisationIndex[civilisationID]].technology_level ++;
        }else if(up == 3){
            require(civilisations[_civilisationIndex[civilisationID]].element_level<3, "Vous êtes déjà au niveau trois des éléments");
            civilisations[_civilisationIndex[civilisationID]].element_level ++;
        }
    }

    //MAJ de l'âge de la civilisation
    function checkAge(bytes32 civilisationID) internal{
        if (civilisations[_civilisationIndex[civilisationID]].divinity_level > 0 && civilisations[_civilisationIndex[civilisationID]].technology_level > 0 && civilisations[_civilisationIndex[civilisationID]].element_level > 0){
           civilisations[_civilisationIndex[civilisationID]].age = 2; 
        }
        if (civilisations[_civilisationIndex[civilisationID]].divinity_level > 1 && civilisations[_civilisationIndex[civilisationID]].technology_level > 1 && civilisations[_civilisationIndex[civilisationID]].element_level > 1){
           civilisations[_civilisationIndex[civilisationID]].age = 1; 
        }
        if (civilisations[_civilisationIndex[civilisationID]].divinity_level == 3 && civilisations[_civilisationIndex[civilisationID]].technology_level == 3 && civilisations[_civilisationIndex[civilisationID]].element_level == 3){
           civilisations[_civilisationIndex[civilisationID]].age = 3; 
        }
    }

    function blockStamp() internal{
        players[_playerIndex[msg.sender]].last_action = block.number;
    }

    function aToiDeJouer() internal view returns (bool){
        //Mode prod
        //return players[_playerIndex[msg.sender]].last_action + 500 < block.number;
        //Mode debug
        return players[_playerIndex[msg.sender]].last_action + 1 < block.number;
    }

    function attributionMerveille(address empereur) internal{
        bytes32 empire = players[_playerIndex[empereur]].originCivilisation;
        civilisations[_civilisationIndex[empire]].merveille ++;
    }

    function exil(address roiDechu) internal{
        players[_playerIndex[roiDechu]].identity = address(0);
    }

    //*******************Vie et mort des civilisations********************//

//Premiers Ages : la construction
    // Achète une compétence pour monter aux ages suivants
    function nouvelleCompetence(bytes32 civilisationID, uint un_Divin_deux_Techno_trois_Elem) public{
        require(aToiDeJouer(), "Vous ne pouvez jouer que tous les 500 blocs");
        require(voiciMonRoi(civilisationID) == msg.sender, "Vous n'être pas le roi de cette civilisation");
        require(civilisations[_civilisationIndex[civilisationID]].age < 2, "Vous ne pouvez utiliser cette compétence qu'aux ages 0 et 1");
        require(civilisationRichesse(civilisationID, 5000), "Vous devez avoir au moins 5000 sesterces pour mener cette attaque");
        require(un_Divin_deux_Techno_trois_Elem < 4, "Merci de renseigner la catégorie que vous souhaitez voir évoluer");
        monteeEnCompetence(civilisationID, un_Divin_deux_Techno_trois_Elem);
        civilisations[_civilisationIndex[civilisationID]].sesterces -= 5000;
        checkAge(civilisationID);
        blockStamp();
    }
    
    //Attend 500 blocs pour gagner 5000 x "age" sesterses 
    function harmonie(bytes32 civilisationID) public{
        require(aToiDeJouer(), "Vous ne pouvez jouer que tous les 500 blocs");
        require(voiciMonRoi(civilisationID) == msg.sender, "Vous n'être pas le roi de cette civilisation");
        civilisations[_civilisationIndex[civilisationID]].sesterces += 5000 * (civilisations[_civilisationIndex[civilisationID]].age +1);
        blockStamp();
    }

    function rempart(bytes32 civilisationID) public{
        require(aToiDeJouer(), "Vous ne pouvez jouer que tous les 500 blocs");
        require(voiciMonRoi(civilisationID) == msg.sender, "Vous n'être pas le roi de cette civilisation");
        require(civilisations[_civilisationIndex[civilisationID]].sesterces >= 8000, "Vous avez déjà érigé un rempart");
        require(civilisations[_civilisationIndex[civilisationID]].remparts ==false, "Vous avez déjà érigé un rempart");
        civilisations[_civilisationIndex[civilisationID]].sesterces -= 8000 ;
        civilisations[_civilisationIndex[civilisationID]].remparts = true;
        blockStamp();

    }

//Second Age : la guerre
    //Pour gagner un age supplémentaire -- permet de faire évoluer sa civilisation
    function combattreCivilisation(bytes32 civilisationAttaquante, bytes32 civilisationAttaquee, uint un_Divin_deux_Techno_trois_Elem) public{
        require(aToiDeJouer(), "Vous ne pouvez jouer que tous les 500 blocs");
        require(voiciMonRoi(civilisationAttaquante) == msg.sender, "Vous n'être pas le roi de cette civilisation");
        require(civilisations[_civilisationIndex[civilisationAttaquee]].age >= 2 && civilisations[_civilisationIndex[civilisationAttaquee]].age >=2, "Vous ou votre adversaire n'avez pas encore le niveau pour vous battre");
        require(civilisationExiste(civilisationAttaquee), "La civilisation attaquée n'existe pas");
        require(civilisationRichesse(civilisationAttaquante, 10000), "Vous devez avoir au moins 1000 sesterces pour mener cette attaque");
        
        //génération de l'attaque
        uint de = generateRandom(6);

        //cas du rempart
        if (civilisations[_civilisationIndex[civilisationAttaquee]].remparts = true){
            civilisations[_civilisationIndex[civilisationAttaquee]].remparts = false;
            de = 1;
        }

        //déroulé de l'attaque
        if (de > 3){
            //Gain de compétence
            monteeEnCompetence(civilisationAttaquante, un_Divin_deux_Techno_trois_Elem);
            checkAge(civilisationAttaquante);

            //Bonus attaquant si 6
            if (de == 6){
            harmonie(civilisationAttaquante);
            }
        }else{
            //Paiement de la rançon du chef
            paiementRancon(civilisationAttaquee,civilisationAttaquante,10000);

            //Bonus défenseur si 1
            if (de == 1){
            harmonie(civilisationAttaquee);
            }
        }
                blockStamp();

    }

    //Troisième age : la domination
    function capturerCivilisation(bytes32 civilisationAttaquante, bytes32 civilisationAttaquee) public{
        require(aToiDeJouer(), "Vous ne pouvez jouer que tous les 500 blocs");
        require(voiciMonRoi(civilisationAttaquante) == msg.sender, "Vous n'être pas le roi de cette civilisation");
        require(civilisations[_civilisationIndex[civilisationAttaquante]].age == 3, "Il vous faut être du troisième age pour pouvoir utiliser cette attaque");
        require(civilisationExiste(civilisationAttaquee), "La civilisation attaquée n'existe pas"); 
        require(civilisationRichesse(civilisationAttaquante, 30000), "Vous devez avoir au moins 30000 sesterces pour mener cette capture");

        uint de = generateRandom(6); 
        if (de == 6){
            if (voiciMonRoyaume(voiciMonRoi(civilisationAttaquee)).length == 0)
            changementDAllegence(voiciMonRoi(civilisationAttaquante),civilisationAttaquee);
        }else{
            //Paiement de la rançon du chef
            paiementRancon(civilisationAttaquee,civilisationAttaquante,30000);
        }
                blockStamp();
    }

        function soumission(bytes32 civilisationPrelevee, bytes32 civilisationPrelevante, uint aideVersee) public{
        require(aToiDeJouer(), "Vous ne pouvez jouer que tous les 500 blocs");
        require(voiciMonRoi(civilisationPrelevante) == msg.sender, "Vous n'être pas le roi de cette civilisation");
        require(civilisations[_civilisationIndex[civilisationPrelevante]].age == 3, "Il vous faut être du troisième age pour pouvoir utiliser cette attaque");
        
        paiementRancon(civilisationPrelevante,civilisationPrelevee,aideVersee);
                blockStamp();
    }

//Confère une richesse infine à une civilisation donnée
           function richesseInfine(bytes32 civilisationID) public{
        require(aToiDeJouer(), "Vous ne pouvez jouer que tous les 500 blocs");
        require(voiciMonRoi(civilisationID) == msg.sender, "Vous n'être pas le roi de cette civilisation");
        require(civilisations[_civilisationIndex[civilisationID]].age == 3, "Il vous faut être du troisième age pour pouvoir utiliser cette attaque");
        
        uint de = generateRandom(1001); 
        if (de == 1001){
        civilisations[_civilisationIndex[civilisationID]].sesterces -= (civilisations[_civilisationIndex[civilisationID]].sesterces +1);
        }
                blockStamp();
    }



    //*************Désignation du vainqueur**************//

    function gloireDuRoyaume(bytes32 civilisationID) internal view returns (uint){
    uint gloire = civilisations[_civilisationIndex[civilisationID]].age * civilisations[_civilisationIndex[civilisationID]].sesterces;
    return gloire;    
    }

    function gloireDuRoi(address roi) internal view returns (uint){
        bytes32[7] memory royaume = voiciMonRoyaume(roi);
        uint gloire = 1;
            for (uint8 i = 0; i < royaume.length; i++){
                gloire = gloire * gloireDuRoyaume(royaume[i]);
                i++;
            }

            // To Do : bonus pour les rois polyvalents cad sur plusieurs types

        return gloire;
    }

    //fonction à invoquer tous les 50 000 blocs (toutes les semaines) pour désigner le joueur gagnant : celui qui a le plus de gloire
    function couronnementDeLEmpereur() public returns (address){
        
        require(players[0].last_action + 50000 < block.number,"Il n'est pas encore temps d'invoquer le nouvel empereur");
        uint glory = 0;
        address empereur;
        for (uint i = 1; i <= players.length; i++){
            if(civilisationRichesse(civilisationOriginelle(players[i].identity), 50000)){
                uint temp = gloireDuRoi(players[i].identity);
                if(temp>glory){
                    glory = temp;
                    empereur = players[i].identity;
                }
            }
        }

        //Un nouveau roi est couronné empereur. Il peut prétendre à construire une merveille contre 50000 sesterces.
        civilisations[_civilisationIndex[civilisationOriginelle(empereur)]].sesterces -= 50000;
        attributionMerveille(empereur);

        players[0].last_action += 50000;

        return empereur;
        }
}  