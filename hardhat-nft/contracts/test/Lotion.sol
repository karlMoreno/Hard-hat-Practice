// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract LotionNFT is ERC721 {
    struct Ingredient {
        address wallet;
        string name;
    }
    
    struct Lotion {
        uint256 id;
        string name;
        string description;
        Ingredient[] ingredients;
    }
    
    Lotion[] private lotions;
    
    constructor() ERC721("LotionNFT", "LOTION") {}
    
    function createLotion(string memory _name, string memory _description, Ingredient[] memory _ingredients) public {
        uint256 newId = lotions.length;
        lotions.push(Lotion(newId, _name, _description, _ingredients));
        
        _safeMint(msg.sender, newId);
    }
    
    function getLotion(uint256 _tokenId) public view returns (Lotion memory) {
        return lotions[_tokenId];
    }
}