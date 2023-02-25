// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8; // 0.8.18 latest version

contract SimpleStorage {
    // a contract that stores a favorite number,
    // automatically initialzied to 0
    uint256 favoriteNumber;

    mapping(string => uint256) public nameToFavoriteNumber;

    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }

    function retrieve() public view returns (uint256) {
        return favoriteNumber;
    }

    struct People {
        uint256 favoriteNumber;
        string name;
    }
    // uint256[] public favNumList;
    // contract takes array index position to find person
    People[] public people;

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        // Can use bracket notation to search full object
        // or just type parameters as they are shown
        people.push(People(_favoriteNumber, _name));
        //maps the name value to its favorite number so no need for indexing
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}
