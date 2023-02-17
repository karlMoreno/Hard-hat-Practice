pragma solidity >=0.7.0 <0.9.0;

contract NFT {
    // Event to track token creation
    event NewToken(
        uint256 indexed tokenId,
        string name,
        string description
    );

    // Mapping to store the token data
    mapping (uint256 => struct TokenData) public tokens;
    struct TokenData {
        string name;
        string description;
        uint256 owner;
    }

    // Generates a unique token ID
    function _createTokenId() private view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(
            now,
            msg.sender
        )));
    }

    // Creates a new token and stores it in the mapping
    function createToken(string memory name, string memory description) public {
        uint256 tokenId = _createTokenId();
        tokens[tokenId] = TokenData(name, description, msg.sender);
        emit NewToken(tokenId, name, description);
    }

    // Transfers the ownership of a token to a new address
    function transferToken(uint256 tokenId, address newOwner) public {
        require(tokens[tokenId].owner == msg.sender, "You are not the owner of this token.");
        tokens[tokenId].owner = newOwner;
    }
}
