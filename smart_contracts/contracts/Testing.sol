// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract Testing {
    constructor(){

    }

    function builtInFuncs() external {
        uint256 num = 0.1 gwei;
        uint gasLeft = msg.gas;

        //For modulo addition and multiplication.
        //For example, addmod(x,y,k) calculates (x + y) % k.
        uint num1 = addmod(40, 90, 3);
        uint num2 = mulmod(3, 5, 3);

        bytes32 res1 = keccak256("something");
        bytes32 res2 = sha3("something");
        bytes32 res3 = sha256("something");
        bytes20 res4 = ripemd160("something");


    /* recover the address associated with the public key from elliptic curve signature or return zero on error.
    The function parameters correspond to ECDSA values of the signature:*/
        address someAddr = ecrecover(res1, 27, res2, res3);

        //Destroy the current contract, sending its funds to the given Address and end execution.
        selfdestruct(someAddr);

        //The address of the currently executing contract account.
        address(this);
    }

    function toCallExternalFunc() external {
        //an external function cannot be called by another function within the same contract
        //except the function is explicitly prefixed with the keyword this
        this.builtInFuncs();
    }
}
