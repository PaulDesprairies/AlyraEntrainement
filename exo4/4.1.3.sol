pragma solidity ^0.5.3;


import "github.com/OpenZeppelin/openzeppelin-solidity/contracts/math/SafeMath.sol";

contract Credibilite {


   using SafeMath for uint256;


   mapping (address => uint256) public cred;

   bytes32[] private devoirs;
   
   
   function produireHash(string memory url) public pure returns(bytes32){
        return keccak256(abi.encode(url));
   }
   
   function transfer(address payable destinataire, uint valeur) public payable{
       require(cred[msg.sender] > valeur); 
       destinataire.transfer(valeur);
    }
    
    function remettre(bytes32 dev) public payable{
        devoirs.push(dev);
        
    }   
   
}