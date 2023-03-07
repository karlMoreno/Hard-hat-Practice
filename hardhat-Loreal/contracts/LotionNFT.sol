// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "base64-sol/base64.sol";

contract LotionNFT is ERC721 {
    uint256 private _tokenIdTracker; // Tracks the current token ID for minting new NFTs
    mapping(uint256 => address[3]) private _tokenData; // Maps token IDs to the addresses and ingredients used to create the lotion
    string private _baseURI; // The base URI for token metadata

    constructor(string memory name, string memory symbol, string memory baseURI) ERC721(name, symbol) {
        _baseURI = baseURI;
    }

    /**
     * @dev Creates a new LotionNFT with the given wallet addresses and ingredients.
     * @param wallet1 The address of the first wallet to use for ingredients.
     * @param ingredient1FromWallet1 The first ingredient to use from the first wallet.
     * @param ingredient2FromWallet1 The second ingredient to use from the first wallet.
     * @param wallet2 The address of the second wallet to use for ingredients.
     * @param ingredient1FromWallet2 The first ingredient to use from the second wallet.
     * @param ingredient2FromWallet2 The second ingredient to use from the second wallet.
     * @param wallet3 The address of the third wallet to use for ingredients.
     * @param ingredient1FromWallet3 The first ingredient to use from the third wallet.
     * @param ingredient2FromWallet3 The second ingredient to use from the third wallet.
     * @return The token ID of the new LotionNFT.
     */
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
        // Ensure all wallet addresses are valid
        require(wallet1 != address(0) && wallet2 != address(0) && wallet3 != address(0), "Invalid address");
        // Ensure all ingredient strings are non-empty
        require(bytes(ingredient1FromWallet1).length > 0 && bytes(ingredient2FromWallet1).length > 0
                && bytes(ingredient1FromWallet2).length > 0 && bytes(ingredient2FromWallet2).length > 0
                && bytes(ingredient1FromWallet3).length > 0 && bytes(ingredient2FromWallet3).length > 0, "Invalid ingredients");

        _tokenIdTracker++; // Increment the token ID tracker to assign a new token ID to the LotionNFT

        // Map the new token ID to the provided addresses and ingredients
        _tokenData[_tokenIdTracker] = [wallet1, wallet2, wallet3];

        // Mint the new LotionNFT to the sender of the transaction
        _mint(msg.sender, _tokenIdTracker);

        // Return the new token ID
        return _tokenIdTracker;
    }

    /**
     * @dev Returns the metadata URI for the given token ID.
     * @param tokenId The ID of the token to get the metadata for.
     * @return The metadata URI for the given token ID.
     */
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
       
