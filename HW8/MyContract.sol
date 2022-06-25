// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract MyContract {
    uint amount;
    uint value;
    constructor (uint initialAmount, uint initialValue) public {
        amount = 0;
        value = 1000;
    }
    function getBalance() public view returns(uint) {
        return value;
    }
    function getAmount() public view returns(uint) {
        return amount;
    }
    function send(uint newDeposit) public {
        value = value - newDeposit;
        amount = amount + newDeposit;
    }
}