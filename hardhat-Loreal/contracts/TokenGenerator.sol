//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract TokenGenerator is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("TokenGenerator", "TGEN") {}

    function generateTokens(address[] memory receivers) public {
        require(receivers.length == 4, "Must provide exactly 4 receivers");

        for (uint i = 0; i < receivers.length; i++) {
            _tokenIds.increment();
            uint256 newTokenId = _tokenIds.current();
            _mint(receivers[i], newTokenId);
        }
    }
}


