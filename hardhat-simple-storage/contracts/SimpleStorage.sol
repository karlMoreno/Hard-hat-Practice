// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8; // 0.8.18 latest version

contract SimpleStorage {
    // a contract that stores a favorite number, 
    // automatically initialzied to 0
    uint256 favoriteNumber;

    function store(uint256 _favoriteNumber) public{
        favoriteNumber = _favoriteNumber;
    }

    struct People {
        uint256 favoriteNumber;
        string name;
    }
}