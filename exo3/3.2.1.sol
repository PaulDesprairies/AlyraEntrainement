//Write your own contracts here. Currently compiles using solc v0.4.15+commit.bbb8e64f.
contract Cogere {

  mapping (address => uint) organisateur;

  constructor() public{
    organisateur[msg.sender] = 100;
  }


  function estOrga(address orga) public returns (bool){
    // assuming any organizer detain a non zero share
    if (organisateur[orga] > 0){
      return true;
    }else{
      return false;
    }
  }

  function transfererOrga(address orga, uint parts) public {
    require(estOrga(orga), "Vous devez être organisateurs.");
    require(parts <= organisateur[msg.sender], "Vous ne pouvez pas donner plus de parts que vous n'en avez déjà.");
    organisateur[msg.sender] = 100 - parts;
    organisateur[orga] = parts;
  }

}

contract CagnotteFestival is Cogere {

    mapping (address => bool) festivaliers;

  function acheterTicket() public payable {
    require(msg.value>500,"Place à 0,50 Ether");
    festivaliers[msg.sender] = true;
  }
  
  function payer(address destinataire, uint montant) public {
    require(estOrga(msg.sender), "Seuls les organisateurs peuvent payer.");
    require(destinataire != 0x0, "Merci de renseigner une adresse valide.");
    require(montant>0, "Merci de renseigner un montant non nul.");
    destinataire.transfer(montant);
  }
}