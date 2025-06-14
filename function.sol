//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

contract ThreeFunctions {
    // execution cost 1 - 121 gas
    // executuoin cost 2 - 143 gas
    // execution cost 3 - 165 gas
    function one() public pure {}

    function two() public pure {}

    function three() public pure {}

    //> function names are converted into bytes
    //> first 4 bytes are taken into consideration for ordering of functions
    //> then they are arranged in ascending order

    //? when fn 1 is called 
    //? it will comapre the fn name converted intp bytes with the arranged order respectively
    //? to check if its the function thats being called
}
