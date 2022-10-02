// SPDX-License-Identifier: UNLICENSED
// www.patika.dev
pragma solidity ^0.8.0;

contract basicFunding {

struct topFunders {
    uint totalFunds;
    address funderAddr;
}

uint collectedFunds; // how many Ethers collected totally
address ownerAddr = 0xdD870fA1b7C4700F2BD7f44238821C26f7392148; // address that can withdraw all the funds
mapping(address => uint) allFunders; // map to store who funded how many Ethers
topFunders[3] topThreeFunders;

function fund() public payable {
    allFunders[msg.sender] += msg.value;
    collectedFunds += msg.value;
    uint totalFundbyThisFunder = allFunders[msg.sender];
    if(totalFundbyThisFunder > topThreeFunders[0].totalFunds){
        topThreeFunders[2].funderAddr = topThreeFunders[1].funderAddr;
        topThreeFunders[2].totalFunds = topThreeFunders[1].totalFunds;

        topThreeFunders[1].funderAddr = topThreeFunders[0].funderAddr;
        topThreeFunders[1].totalFunds = topThreeFunders[0].totalFunds;

        topThreeFunders[0].funderAddr = msg.sender;
        topThreeFunders[0].totalFunds = totalFundbyThisFunder;
    } else if(totalFundbyThisFunder > topThreeFunders[1].totalFunds){
        topThreeFunders[2].funderAddr = topThreeFunders[1].funderAddr;
        topThreeFunders[2].totalFunds = topThreeFunders[1].totalFunds;

        topThreeFunders[1].funderAddr = msg.sender;
        topThreeFunders[1].totalFunds = totalFundbyThisFunder;
    } else if(totalFundbyThisFunder > topThreeFunders[2].totalFunds){
        topThreeFunders[2].funderAddr = msg.sender;
        topThreeFunders[2].totalFunds = totalFundbyThisFunder;
    }
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

function returnTopThreeFunders() public view returns(address, address, address) {
    return (
    topThreeFunders[0].funderAddr, 
    topThreeFunders[1].funderAddr,
    topThreeFunders[2].funderAddr);
}

}
