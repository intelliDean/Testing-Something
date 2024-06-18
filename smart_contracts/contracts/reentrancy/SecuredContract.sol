// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract SecuredContract {
    constructor(){

    }
}



contract SecuredContract {

    // initialize the mutex
    bool private reEntrancyMutex = false;

    uint256 public withdrawalLimit = 1 ether;
    mapping(address => uint256) public lastWithdrawTime;
    mapping(address => uint256) public balances;

    function depositFunds() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdrawFunds (uint256 _weiToWithdraw) public {
        require(!reEntrancyMutex);

        require(balances[msg.sender] >= _weiToWithdraw);
        // limit the withdrawal
        require(_weiToWithdraw <= withdrawalLimit);
        // limit the time allowed to withdraw
        require(block.timestamp >= lastWithdrawTime[msg.sender] + 1 weeks);

        balances[msg.sender] -= _weiToWithdraw;
        lastWithdrawTime[msg.sender] = block.timestamp;

        // set the reEntrancy mutex before the external call
        reEntrancyMutex = true;
        //transfer function sends 2300 gas with the transaction, which is just enough
        //to transfer the ether and no other execution
        msg.sender.transfer(_weiToWithdraw);
        // release the mutex after the external call
        reEntrancyMutex = false;
    }
}