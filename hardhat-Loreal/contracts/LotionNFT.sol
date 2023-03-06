// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract LotionNFT is ERC721 {
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  mapping(uint256 => address[3]) private _walletAddresses;
  mapping(uint256 => string[6]) private _ingredients;

  constructor() ERC721("LotionNFT", "LNFT") {}

  function createLotion(
    address wallet1,
    string memory ingredient1FromWallet1,
    string memory ingredient2FromWallet1,
    address wallet2,
    string memory ingredient1FromWallet2,
    string memory ingredient2FromWallet2,
    address wallet3,
    string memory ingredient1FromWallet3,
    string memory ingredient2FromWallet3
  ) public returns (uint256) {
    _tokenIds.increment();

    uint256 newTokenId = _tokenIds.current();
    _mint(msg.sender, newTokenId);

    _walletAddresses[newTokenId][0] = wallet1;
    _walletAddresses[newTokenId][1] = wallet2;
    _walletAddresses[newTokenId][2] = wallet3;

    _ingredients[newTokenId][0] = ingredient1FromWallet1;
    _ingredients[newTokenId][1] = ingredient2FromWallet1;
    _ingredients[newTokenId][2] = ingredient1FromWallet2;
    _ingredients[newTokenId][3] = ingredient2FromWallet2;
    _ingredients[newTokenId][4] = ingredient1FromWallet3;
    _ingredients[newTokenId][5] = ingredient2FromWallet3;

    return newTokenId;
  }

  function getLotion(
    uint256 tokenId
  ) public view returns (address[3] memory, string[6] memory) {
    require(_exists(tokenId), "Lotion does not exist");
    return (_walletAddresses[tokenId], _ingredients[tokenId]);
  }
}
