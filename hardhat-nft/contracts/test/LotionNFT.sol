// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract LotionNFT is ERC721, ERC721Enumerable {
    using Strings for uint256;
    using EnumerableSet for EnumerableSet.AddressSet;

    uint256 private lotionCounter;
    mapping(uint256 => string) private lotionNames;
    mapping(uint256 => string) private lotionDescriptions;
    mapping(uint256 => EnumerableSet.AddressSet) private lotionIngredients;

    constructor() ERC721("LotionNFT", "LOTION") {}

    function createLotion(string memory _name, string memory _description, address[] memory _ingredientsWallets, string[] memory _ingredientsNames, uint256 _tokenID) public {
        require(_isApprovedOrOwner(msg.sender, _tokenID), "LotionNFT: Only the owner or an approved user can use this token");

        uint256 newId = lotionCounter;
        lotionCounter++;

        lotionNames[newId] = _name;
        lotionDescriptions[newId] = _description;

        for (uint256 i = 0; i < _ingredientsWallets.length; i++) {
            lotionIngredients[newId].add(_ingredientsWallets[i]);
        }

        _safeMint(msg.sender, newId);

        string memory tokenURI = getLotionTokenURI(newId);
        _setTokenURI(newId, tokenURI);
    }

    function getLotion(uint256 _tokenId) public view returns (string memory, string memory, address[] memory, string[] memory) {
        EnumerableSet.AddressSet storage ingredientsSet = lotionIngredients[_tokenId];
        address[] memory ingredientsWallets = new address[](ingredientsSet.length());
        string[] memory ingredientsNames = new string[](ingredientsSet.length());

        for (uint256 i = 0; i < ingredientsSet.length(); i++) {
            address ingredientWallet = ingredientsSet.at(i);
            ingredientsWallets[i] = ingredientWallet;

            for (uint256 j = 0; j < ingredientsWallets.length; j++) {
                if (ingredientsWallets[j] == ingredientWallet) {
                    require(false, "LotionNFT: Duplicate ingredient wallet found");
                }
            }

            for (uint256 j = 0; j < ingredientsNames.length; j++) {
                if (keccak256(abi.encodePacked(ingredientsNames[j])) == keccak256(abi.encodePacked(_ingredientsNames[i]))) {
                    require(false, "LotionNFT: Duplicate ingredient name found");
                }
            }

            ingredientsNames[i] = _ingredientsNames[i];
        }

        return (lotionNames[_tokenId], lotionDescriptions[_tokenId], ingredientsWallets, ingredientsNames);
    }

    function addressToString(address _address) internal pure returns (string memory) {
    bytes32 _bytes = bytes32(uint256(_address));
    bytes memory HEX = "0123456789abcdef";
    bytes memory _string = new bytes(42);

    _string[0] = '0';
    _string[1] = 'x';

    for (uint i = 0; i < 20; i++) {
        _string[2+i*2] = HEX[uint8(_bytes[i + 12] >> 4)];
        _string[3+i*2] = HEX[uint8(_bytes[i + 12] & 0x0f)];
    }

    return string(_string);
}

    function getLotionTokenURI(uint256 _tokenId) public view returns (string memory) {
    (string memory name, string memory description, address[] memory ingredientsWallets, string[] memory ingredientsNames) = getLotion(_tokenId);
    string memory tokenID = Strings.toString(_tokenId);

    string memory jsonString = string(abi.encodePacked(
        '{"name":"', name, '", ',
        '"description":"', description, '", ',
        '"ingredients":['));

    for (uint i = 0; i < ingredientsWallets.length; i++) {
        jsonString = string(abi.encodePacked(
            jsonString,
            '{"wallet":"', addressToString(ingredientsWallets[i]), '", ',
            '"name":"', ingredientsNames[i], '"}'));

        if (i < ingredientsWallets.length - 1) {
            jsonString = string(abi.encodePacked(jsonString, ","));
        }
    }

    jsonString = string(abi.encodePacked(
        jsonString,
        '], ',
        '"wallet":"', addressToString(ownerOf(_tokenId)), '", ',
        '"tokenID":"', tokenID, '"}'));

    return string(abi.encodePacked("data:application/json;base64,", Base64.encode(bytes(jsonString))));
}

}