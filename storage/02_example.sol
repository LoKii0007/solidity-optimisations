// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title VariablePacking vs Unpacked Storage Comparison
/// @notice Demonstrates gas usage difference between packed and unpacked storage layouts

contract VariablePacking {
    uint24 public a; // occupies 3 bytes
    uint16 public b; // occupies 2 bytes
    uint8 public c;  // occupies 1 byte

    //? These three variables are packed into a single 32-byte storage slot (slot 0)
    //? This reduces the number of SLOAD/SSTORE operations needed at runtime
    //? However, packing adds minor overhead during deployment due to bit-masking
    //? Deployment gas cost: ~85,133
}

contract Unpacked {
    uint256 public a;
    uint256 public b;
    uint256 public c;

    //? Each variable occupies its own 32-byte slot (slots 0, 1, and 2)
    //? This increases read/write cost at runtime, but deployment is cheaper
    //? Deployment gas cost: ~51,297
}

//* Summary:
//! - Deployment Cost:
//?     Unpacked is cheaper (~51.3k) because no bit-level packing/unpacking is needed.
//!
//! - Runtime Read/Write Cost:
//?     VariablePacking is cheaper for both SLOAD and SSTORE operations
//?     because all variables reside in the same storage slot.
//!
//! - Explanation:
//?     In Unpacked, each SLOAD/SSTORE accesses a separate slot,
//?     resulting in 3x the storage operation cost (cold/warm slots).
//?     In VariablePacking, all variables are in a single slot,
//?     so only one SLOAD/SSTORE is needed, with bitwise operations handled by the compiler.
//?
//?     Read/write savings from VariablePacking outweigh the higher deployment cost
//?     after just a few interactions.
