pragma solidity ^0.5.6;
pragma experimental ABIEncoderV2;


contract JeuDesCivilisations {


    enum Identity {SAGE, AGRESSIF, RECLU, IMPREVISIBLE} //AGE 1 - Identité
    enum Element_1 {SOL, CIEL, FEU, EAU} //AGE 2 - Element niveau 1
    enum Divinity_1 {SCANDINAVE, GREC, HINDU, EGYPTIENS} //AGE 3 - Divinité niveau 1/2
    enum Element_2 {TERRE, LUMIERE, FOUDRE, GLACE} //AGE 4 - Element niveau 2
    enum Technology_1 {ATOME, PHOTON, OBSCURITE, PHILOSOPHIE} //AGE 5 - Technologie niveau 1
    enum Technology_2 {ELECTRON, LUMIERE, ANTIPARTICULE, UNIVERSALITE} //AGE 6 - Technologie niveau 2
    enum Element_3 {KERNEL, SOLAIRE, PLASMA, CRISTAL} //AGE 7 - Element niveau 3
    enum Technology_3 {PLASMA, ETOILE, TROU_NOIR, OMNISCIENCE} //AGE 8 - Technologie niveau 3
    enum Divinity_3 {RAGNAROK, OLYMPUS, QOMOLANGMA, IKHERNOFRET} //AGE 9 - Divinité niveau 3

    struct Civilisation {
        address founder;
        address owner;
        string name;
        uint age;
        Identity[] identity;
        Divinity_1[] divinity_1;
        Divinity_3[] divinity_3;
        Technology_1[] technology_1;
        Technology_2[] technology_2;
        Technology_3[] technology_3;
        Element_1[] element_1;
        Element_2[] element_2;
        Element_3[] element_3;
        uint sesterces;
        bytes32 signature;   
    }

    Civilisation[] civilisations;
    mapping (bytes32 => uint) private _civilisationIndex;
    uint nbCivilisation = 1;

    struct Player {
        string name;
        address identity;
        bytes32 originCivilisation;
        bytes32[] ownedCivilisations;
    }

    Player[] players;
    mapping(address => uint) _playerIndex;
    uint nbJoueurs = 1;



///Génère un chiffre random de 1 à 4
    function generateId() private view returns (uint) {
        uint256 genId = uint256(blockhash(block.number-1));
        genId = uint(genId % 4) + 1 ;
        return genId;
    }

///**************Initialisation*************//
    function fonderCivilisation(string memory _namePlayer, string memory _nameCivilisation) public payable returns (bytes32){

        require(_playerIndex[msg.sender] == 0, "Vous ne pouvez pas fonder deux civilisations");
        require(msg.value == 0.1 ether, "Une fondation coûte 0.1 ether");
        bytes32 signature = blockhash(block.number-1);
        require(civilisations[_civilisationIndex[signature]].owner == address(0), "Cette civilisation a déjà été fondée");

        Player memory nouveauJoueur;
        Civilisation memory nouvelleCivilisation;

        //Nouveau joueur
        nouveauJoueur.name = _namePlayer;
        nouveauJoueur.identity = msg.sender;
        nouveauJoueur.originCivilisation = signature;
        nouveauJoueur.ownedCivilisations[0] = signature;
        _playerIndex[msg.sender] = nbJoueurs;
        nbJoueurs++;

        //Nouvelle civilisation
        nouvelleCivilisation.signature = signature;
        nouvelleCivilisation.name = _nameCivilisation;
        nouvelleCivilisation.age = 1;
        nouvelleCivilisation.identity[0] = JeuDesCivilisations.Identity(generateId());
        nouvelleCivilisation.owner = msg.sender;
        nouvelleCivilisation.founder = msg.sender;
        nouvelleCivilisation.sesterces = 1000;
        _civilisationIndex[signature] = nbCivilisation;
        nbCivilisation++;

        players.push(nouveauJoueur);
        civilisations.push(nouvelleCivilisation);

        return signature;
    }
    
    //*************Informations**************//
    function voiciMonRoyaume(address owner) public view returns (bytes32[] memory){
        bytes32[] memory royaume = players[_playerIndex[owner]].ownedCivilisations;
        require(royaume.length != 0, "Vous êtes un imposteur");
        return royaume;
    }

    function voiciMonRoi(bytes32 civilisationID) public view returns (address) {
        address roi = civilisations[_civilisationIndex[civilisationID]].owner;
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

    function leguerCivilisation(address from, address to, bytes32 civilisationID) public {
        require(voiciMonRoi(civilisationID) == from);
        require(to != address(0));
        civilisations[_civilisationIndex[civilisationID]].owner = to;
    }

    //*******************Combats********************//


    //Pour gagner un age supplémentaire -- permet de faire évoluer sa civilisation
    function combattreCivilisation(bytes32 civilisationAttaquante, bytes32 civilisationAttaquee) public view{
        require(civilisationExiste(civilisationAttaquante), "La civilisation attaquante n'existe pas");
        require(civilisationExiste(civilisationAttaquee), "La civilisation attaquée n'existe pas");

    }

    //Pour piller une civilisation -- permet d'obtenir une compétence supplémentaire. Les quatre compétences permettent de faire monter d'un âge
    function pillerCivilisation(bytes32 civilisationAttaquante, bytes32 civilisationAttaquee) public view{
        require(civilisationExiste(civilisationAttaquante), "La civilisation attaquante n'existe pas");
        require(civilisationExiste(civilisationAttaquee), "La civilisation attaquée n'existe pas");
    }

    //Pour capturer une civilisation -- permet d'étendre son royaume
    function capturerCivilisation(bytes32 civilisationAttaquante, bytes32 civilisationAttaquee) public view{
        require(civilisationExiste(civilisationAttaquante), "La civilisation attaquante n'existe pas");
        require(civilisationExiste(civilisationAttaquee), "La civilisation attaquée n'existe pas");  

    }

    //*************Désignation du vainqueur**************//

    function gloireDuRoi(address owner) public view returns (uint){
        voiciMonRoyaume(owner);
        /// calculer la gloire du roi en calculant la somme des gloires des royaumes
        return 0;
    }

    //fonction à invoquer en fin de partie pour désigner le joueur gagnant : celui qui a le plus de gloire
    function couronnementDeLEmpereur() public view returns (address){
        
        uint glory = 0;
        address empereur;
        for (uint i = 1; i <= players.length; i++){
            uint temp = gloireDuRoi(players[i].identity);
            if(temp>glory){
                glory = temp;
                empereur = players[i].identity;
            }
        }

        return empereur;
    }
}   