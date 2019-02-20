//Write your own contracts here. Currently compiles using solc v0.4.15+commit.bbb8e64f.

pragma solidity 0.4.25;

contract Cogere {

using SafeMath for uint256;

  uint[] private depensesJournalieres;
  uint private depensesTotales;
  uint private dernierPaiement;
  uint private comptabiliserRecettes;
  uint8 private balance;
  uint public nbSMax;
  uint public dateFestival;
  uint public dateLiquidation;
  uint public montantMaxJour;
  mapping (address => uint8) organisateur;
  mapping (address => bool) festivaliers;

  struct Sponsor{
    mapping (string => bool) mecenat;
    }

  Sponsor[] sponsors;

  constructor(uint nbSponsorMax, uint date, uint montant) public{
    organisateur[msg.sender] = 100;
    nbSMax = nbSponsorMax;
    dateFestival = date;
    dateLiquidation = date + 2 weeks;
    montantMaxJour = montant;
  }


  function estOrga(address orga) view public returns (bool){
    // assuming any organizer detain a non zero share
    if (organisateur[orga] > 0){
      return true;
    }else{
      return false;
    }
  }

  function transfererOrga(address orga, uint8 parts) public {
    require(estOrga(orga), "Vous devez être organisateurs.");
    require(parts <= organisateur[msg.sender], "Vous ne pouvez pas donner plus de parts que vous n'en avez déjà.");
    organisateur[msg.sender] = 100 - parts;
    organisateur[orga] += parts;
  }

    function comptabiliserDepenses(uint montant) private returns (uint){
    depensesJournalieres[timeline()] += montant;
    uint8 i =0;
    while (i < 14){
      depensesTotales = depensesJournalieres[i];
      i+=1;
    }
    return depensesTotales;
  }


  function acheterTicket() public payable {
    require(msg.value>500 finney,"Place à 0,50 Ether");
    festivaliers[msg.sender] = true;
    comptabiliserRecettes += 500 finney;
  }

  function payer(address destinataire, uint montant) public {
    require(estOrga(msg.sender), "Seuls les organisateurs peuvent payer.");
    require(destinataire != 0x0, "Merci de renseigner une adresse valide.");
    require(montant>0, "Merci de renseigner un montant non nul.");
    require(depensesJournalieres[timeline()] + montant < montantMaxJour,"Vous avez atteint le plafond pour aujourd'hui." );
    
    destinataire.transfer(montant);
    comptabiliserDepenses(montant);
     
  }

  function sponsoriser(string memory nom) public payable {
    require(msg.value>30000 finney,"Sponsoring à 300 Ether");
    require(sponsors.length <= nbSMax, "La limite de sponsors est atteinte.");
    sponsors[sponsors.length-1].mecenat[nom] = true;
    comptabiliserRecettes += 30000 finney;
  }

  function timeline() public view returns (uint){
    uint jour = (dateLiquidation - dateFestival) / 14;
    return jour = ((now - dateFestival) % jour) ;
  }

  function retraitOrga() public payable{
     require(estOrga(msg.sender));
     require(block.timestamp >= dateLiquidation);
     //remboursement à hauteur des parts
    msg.sender.transfer(comptabiliserRecettes * (organisateur[msg.sender]/100));
    // enlever le statut d'organisateur
    organisateur[msg.sender] = 0;
    // recomptage avant autodestruction
    balance += organisateur[msg.sender];
    if (balance == 100){
      selfdestruct(msg.sender);
    }
  }
}

/***************************************LIBRARY********************************************

pragma solidity 0.4.25;

/**
 * @title SafeMath
 * @dev Unsigned math operations with safety checks that revert on error
 */
library SafeMath {
    /**
     * @dev Multiplies two unsigned integers, reverts on overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b);

        return c;
    }

    /**
     * @dev Integer division of two unsigned integers truncating the quotient, reverts on division by zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Subtracts two unsigned integers, reverts on overflow (i.e. if subtrahend is greater than minuend).
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Adds two unsigned integers, reverts on overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a);

        return c;
    }

    /**
     * @dev Divides two unsigned integers and returns the remainder (unsigned integer modulo),
     * reverts when dividing by zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0);
        return a % b;
    }
}