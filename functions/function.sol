// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

//! @title Function Selector Ordering Gas Comparison
//? @notice Demonstrates how function ordering affects gas usage during external calls

contract oneFunction{
    function one() public pure {}

    //? Execution Cost Estimates (External Call via a Wallet/Contract):
    // one()    → ~121 gas
}

contract TwoFunction{
    function one() public pure {}
    function two() public pure {}

    //? Execution Cost Estimates (External Call via a Wallet/Contract):
    // one()    → ~143 gas
    // two()    → ~121 gas
}

contract ThreeFunctions {
    //? Execution Cost Estimates (External Call via a Wallet/Contract):
    // one()    → ~165 gas
    // two()    → ~143 gas
    // three()  → ~121 gas

    function one() public pure {}

    function two() public pure {}

    function three() public pure {}

    // Explanation:
    //> When a function is called, the function *selector* (first 4 bytes of keccak256 hash of the signature)
    //> is compared against the sorted list of function selectors embedded in the contract’s dispatcher.
    //
    //> The EVM searches through this selector table in ascending order.
    //> The more comparisons required to find a match, the more gas is consumed.
    //
    // For example:
    //  - `three()` happens to have the first selector in sorted order → fewer comparisons → least gas
    //  - `two()` matches after one check → slightly more gas
    //  - `one()` matches after two checks → most gas among the three
    //
    //? This is why function order in source code ≠ actual matching order;
    //? it’s the sorted order of the **function selectors** that matters.
    //
    // You can verify selectors with:
    //   bytes4(keccak256("one()"))    // 901717d1
    //   bytes4(keccak256("two()"))    // 5fdf05d7
    //   bytes4(keccak256("three()"))  // 45caa117
}
