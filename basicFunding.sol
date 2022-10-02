// SPDX-License-Identifier: UNLICENSED
// www.patika.dev
pragma solidity ^0.8.0;

contract basicFunding {

uint collectedFunds; // how many Ethers collected totally
address ownerAddr = 0xdD870fA1b7C4700F2BD7f44238821C26f7392148; // address that can withdraw all the funds
mapping(address => uint) allFunders; // map to store who funded how many Ethers

function fund() public payable {
    allFunders[msg.sender] += msg.value;
    collectedFunds += msg.value;
}

function withdrawFunds(uint amount, address payable addrToCollectFunds) public payable {
    require(msg.sender == ownerAddr, "You are not authorized to withdraw funds.");
    require(amount <= collectedFunds, "Insufficient balance.");
    addrToCollectFunds.transfer(amount);
    collectedFunds -= amount;
}

function returnBalance() public view returns(uint) {
    return collectedFunds;
}

}
