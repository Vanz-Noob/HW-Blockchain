// SPDX-License-Identifier: MIT

// Versi compiler solidity yang akan digunakan
pragma solidity >=0.8.0 <0.9.0;

// Nama smartcontract yang akan di buat
contract SimpleStorage {
    // Jenis variable yang digunakan menggunakan uint256
    uint256 favoriteNumber;

    // Membuat structure People dengan variabel dalamnya adalah uint 256 dan string
    struct People {
        uint256 favoriteNumber;
        string name;
    }
    // uint256[] public anArray;
    // array people akan dibuka menjadi public
    People[] public people;

    //proses mapping nilai string menjadi uint256 yang bersifat public dan disinmpan pada nameToFavoriteNumber
    mapping(string => uint256) public nameToFavoriteNumber;

    //Fungsi store yang gunanya menyimpan favorite number dan bersifat public virtual
    function store(uint256 _favoriteNumber) public virtual {
        favoriteNumber = _favoriteNumber;
    }
    //Fungsi retrieve yang gunanya adalah mengambil nilai value dari favorite number
    function retrieve() public view returns (uint256){
        return favoriteNumber;
    }
    //Fungsi addPersin yang gunanya adalah menyimpan data orang baru beserta nomor favoritenya
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        people.push(People(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}

