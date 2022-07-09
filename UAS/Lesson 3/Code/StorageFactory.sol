// SPDX-License-Identifier: MIT 

// Versi compiler solidity yang akan digunakan
pragma solidity ^0.8.0;

//import smartcontract yang sebelumnya kita buat
import "./SimpleStorage.sol"; 

//nama smartcontract
contract StorageFactory {
    
    //membuat array simplestorage dan bersifat public
    SimpleStorage[] public simpleStorageArray;
    //membuat fungsi create simplestoragecontract dengan fungsi membuat kontrak yang bersifat public
    function createSimpleStorageContract() public {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }
    //membuat fungsi sftore dengan fungsi menyimpan simplestorageindex dan simplestoragenumber secara puclic dan disimpan pada array
    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        // Address 
        // ABI 
        // SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).store(_simpleStorageNumber);
        simpleStorageArray[_simpleStorageIndex].store(_simpleStorageNumber);
    }
    //membuat fungsi sfget dengan fungsi mengambil nilai dari simplestorageindex dan mengembalikan array nialinya
    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256) {
        // return SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).retrieve();
        return simpleStorageArray[_simpleStorageIndex].retrieve();
    }
}
