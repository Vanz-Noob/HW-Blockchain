// SPDX-License-Identifier: MIT

//versi compiler solidity
pragma solidity 0.8.8;
//import simple storage
import "./SimpleStorage.sol";
///membuat smartcontract dengan memanggil simplestorage
contract ExtraStorage is SimpleStorage {
    function store(uint256 _favoriteNumber) public virtual override {
        favoriteNumber = _favoriteNumber + 5;
    }
}

