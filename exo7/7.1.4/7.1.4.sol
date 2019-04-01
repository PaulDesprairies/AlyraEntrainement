pragma solidity ^0.5.6;


contract ERC721simple {

    mapping (address => uint) _token;

    // Mapping from token ID to owner
    mapping (uint256 => address) private _tokenOwner;
    
    function create_token (address token) public view returns (uint){
        return _token[token];
    }

    function balanceOf(address owner) public view{
        ///***///
    }

    function ownerOf(uint256 tokenId) public view returns (address) {
        address owner = _tokenOwner[tokenId];
        require(owner != address(0));
        return owner;
    }

    function _exists(uint256 tokenId) internal view returns (bool) {
        address owner = _tokenOwner[tokenId];
        return owner != address(0);
    }

    function _transferFrom(address from, address to, uint256 tokenId) internal {
        require(ownerOf(tokenId) == from);
        require(to != address(0));
        _tokenOwner[tokenId] = to;

    }

}