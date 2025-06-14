// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

//! title Gas Cost Comparison Between uint8 and uint256

//* GAS COST REFERENCES (per EVM rules):
//> Cold SLOAD access         = +2100 gas (first time accessing a storage slot in a tx)
//> Warm SLOAD access         = +100 gas  (subsequent access to the same slot in a tx)
//> SSTORE (0 → non-zero)     = +20,000 gas
//> SSTORE (non-zero → diff non-zero) = +2,900 gas
//> SSTORE (non-zero → same value)    = +100 gas

//* GAS REFUNDS (if storage is being cleared):
//> SSTORE (non-zero → 0), if originally non-zero = -4,800 gas (refund)
//> SSTORE (0 → non-zero → 0 again)               = -19,900 gas (full refund if zeroed)

//* NOTE:
// The EVM works natively with 32-byte (256-bit) storage slots.
// Using types smaller than 256 bits introduces extra computation
// for bit masking and alignment at both compile time and runtime.

contract GasComparison {
    uint8 public x;

    //? Uses only 1 byte out of the 32-byte slot, but introduces extra gas cost
    //? due to compiler inserting masking logic to ensure correctness
    //? Deployment gas cost: ~37,285
    //? Read/write operations are slightly more expensive than uint256 in isolation
}

contract GasComparison2 {
    uint256 public x;

    //? Uses full 32-byte slot, aligned with EVM’s native word size
    //? No padding or bit-shifting needed; storage is accessed directly
    //? Deployment gas cost: ~34,485
    //? Slightly cheaper and simpler execution path for the EVM
}

//! Why uint256 has *lower gas cost* here despite being a bigger type:
//? - The EVM is optimized for 32-byte words (`uint256`).
//? - Using smaller types like `uint8` within a single-slot contract
//?   doesn’t reduce actual storage usage, but adds overhead for padding, masking, and shifting.
//? - In this isolated case (a single variable), uint256 is more gas-efficient than uint8.
//? - The packing benefit of uint8 only kicks in when multiple small variables
//?   are packed into one slot — not when it’s alone.