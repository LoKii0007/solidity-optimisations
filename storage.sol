//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

//* gas costs

//> cold access = + 2100 
//> warm access = + 100
//> zero to non-zero = + 20000
//> slot startd non-zero and being changed to a diff non-zero value = + 2900
//> new_val = current_value = +100

//* gas refunds (like cashback)

//> new value is zero and slot started as non-zero = +4800
//> slot strted zero, currently non-zero now beong set to zero = + 19900


contract GasComparison{
    uint8 public x;
    //? execution cost - 37285
}

contract GasComparison2{
    uint256 public x;
    //? execution cost - 34485
}

//! why low gas cost for uint256
//? evm has to do extra work to creating paddings bcz of uint8 and the slot size is 32B,
//? so for remaining padding will be crested which costs extra gas
//? in this scenario uint256 will be btter instead of uint8