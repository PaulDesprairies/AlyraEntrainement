contract CagnotteFestival{

  mapping (address => bool) organisateur;
  mapping (address => uint) participation;


  constructor() public{
    participation[msg.sender] = 100;
  }


  function estOrga(address orga) public returns (bool){
    if (organisateur[orga] = true){
      return true;
    }else{
      return false;
    }
  }

  function transfererOrga(address orga, uint parts) public {
    require(estOrga(orga), "Vous devez être organisateurs.");
    require(parts <= participation[msg.sender], "Vous ne pouvez pas donner plus de parts que vous n'en avez déjà.");
    participation[msg.sender] = 100 - parts;
    participation[orga] = parts;
  }
}