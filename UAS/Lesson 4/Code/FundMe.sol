// SPDX-License-Identifier: MIT
//versi compiler solidity yang akan digunakan
pragma solidity ^0.8.8;

//mengimpor modul chain link kedalam smart contract kita
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
//mengimpor code PriceConverter.sol
import "./PriceConverter.sol";

//hasil balikan error jika address didn't match
error NotOwner();

//smartcontract yang bernama FundMe
contract FundMe {
    using PriceConverter for uint256;

    //maping uint256 kedalam address yang bersifat public dan diberi nama addressToAmmountFunded
    mapping(address => uint256) public addressToAmountFunded;
    //hasil mapping address tadi dijadikan array yang bersifat public dan diberi nama funders
    address[] public funders;

    // Could we make this constant?  /* hint: no! We should make it immutable! */
    //membuat fungsi call yang diberi nama i_owner dan immutable
    address public /* immutable */ i_owner;
    //membuat variable USD yang minimum ketika dikirimkan
    // menggunakan constant juga dikarenkan agar nilai gas fee yang kita bayar agar lebih murah dan efisien
    uint256 public constant MINIMUM_USD = 50 * 10 ** 18;
    
    constructor() {
        i_owner = msg.sender;
    }
    //fungsi mengirim uang dari ETH menjadi USD
    function fund() public payable {
        //fungsi untuk memeriksa apakah yang dikirimkan memenuhi minimal yang dapat dikirimkan
        require(msg.value.getConversionRate() >= MINIMUM_USD, "You need to spend more ETH!");
        // require(PriceConverter.getConversionRate(msg.value) >= MINIMUM_USD, "You need to spend more ETH!");
        addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
    }
    
    //function untuk API call untuk mendapatkan harga USD/ETH yang terbaru
    function getVersion() public view returns (uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        return priceFeed.version();
    }
    // pengecekan apakah address punya owner atau bukan
    modifier onlyOwner {
        // require(msg.sender == owner);
        if (msg.sender != i_owner) revert NotOwner();
        _;
    }
    
    // fungsi mengabil uang yang bersifat pembayaran public
    function withdraw() payable onlyOwner public {
        // penglangan pencarian funder dari index 0 dan ketentuannya adalah jika funderIndex kurang dari
        // funders.length dan funderIndex akan inkrement
        for (uint256 funderIndex=0; funderIndex < funders.length; funderIndex++){
            // mengakses nilai funderIndex element dari looping dan disimpan pada funder
            address funder = funders[funderIndex];
            // menreset nilai balance dari mapping
            addressToAmountFunded[funder] = 0;
        }
        // reset array address
        funders = new address[](0);

        // // transfer ETH jika ada yang call fungsi withdraw
        // payable(msg.sender).transfer(address(this).balance);
        // // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed");
        // call
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }
    // Explainer from: https://solidity-by-example.org/fallback/
    // Ether is sent to contract
    //      is msg.data empty?
    //          /   \ 
    //         yes  no
    //         /     \
    //    receive()?  fallback() 
    //     /   \ 
    //   yes   no
    //  /        \
    //receive()  fallback()

    fallback() external payable {
        fund();
    }

    receive() external payable {
        fund();
    }

}

// Concepts we didn't cover yet (will cover in later sections)
// 1. Enum
// 2. Events
// 3. Try / Catch
// 4. Function Selector
// 5. abi.encode / decode
// 6. Hash with keccak256
// 7. Yul / Assembly



