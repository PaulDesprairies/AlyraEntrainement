pragma solidity ^0.5.6;


contract ERC721simple {

    mapping (uint => address) private _tokenOwner;

    function generateRandom() private view returns (uint) {
        uint256 genPrefixe = uint256(blockhash(block.number-1));
        uint256 genSuffixe = uint(genPrefixe % 1000);
        genPrefixe = uint(genPrefixe % 3) * 1000;
        return genPrefixe = genPrefixe + genSuffixe;
    }

    function creuser() public payable returns (address){
        require(msg.value == 0.1 ether, "Creuser coûte 0.1 ether");
        uint token = generateRandom();
        require(_tokenOwner[token] == address(0), "Cet objet existe déjà");
        _tokenOwner[token] = msg.sender;
        return _tokenOwner[token];
    }

    function balanceOf(address owner) public view{
        ///***///
    }

    function ownerOf(uint tokenId) public view returns (address) {
        address owner = _tokenOwner[tokenId];
        require(owner != address(0));
        return owner;
    }

    function _exists(uint256 tokenId) public view returns (bool) {
        address owner = _tokenOwner[tokenId];
        return owner != address(0);
    }

    function _transferFrom(address from, address to, uint256 tokenId) public {
        require(ownerOf(tokenId) == from);
        require(to != address(0));
        tokenId = (tokenId / 1000);
        require (tokenId != 2, "Un objet divin n'est pas transférable");
        _tokenOwner[tokenId] = to;
    }

    function utiliser(uint tokenId) public returns (bool){
        require (ownerOf(tokenId) == msg.sender, "Vous devez être le propriétaire de ce token pour l'utiliser");
        uint alea = generateRandom() / 100;
        if (alea == 0){
            delete _tokenOwner[tokenId];
            return false;
        }
        return true;
    }


}