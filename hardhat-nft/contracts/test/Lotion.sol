// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract LotionNFT is ERC721 {
    struct Ingredient {
        address wallet;
        string name;
    }

    uint256 private lotionCounter;
    mapping(uint256 => string) private lotionNames;
    mapping(uint256 => string) private lotionDescriptions;
    mapping(uint256 => Ingredient[]) private lotionIngredients;

    constructor() ERC721("LotionNFT", "LOTION") {}

    function createLotion(string memory _name, string memory _description, Ingredient[] memory _ingredients) public {
        uint256 newId = lotionCounter;
        lotionCounter++;

        lotionNames[newId] = _name;
        lotionDescriptions[newId] = _description;
        lotionIngredients[newId] = _ingredients;

        _safeMint(msg.sender, newId);
    }

    function getLotion(uint256 _tokenId) public view returns (string memory, string memory, Ingredient[] memory) {
        return (lotionNames[_tokenId], lotionDescriptions[_tokenId], lotionIngredients[_tokenId]);
    }
}