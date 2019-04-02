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
        _tokenOwner[tokenId] = to;
    }
}