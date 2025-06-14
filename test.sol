//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

contract Optimization {
    uint private a;

    function addition() public {
        a = a+1;
    }

    function additionOptimized() public {
        //? no checking of underflow or overflow
        //? in any of the above case 0 or some random value will be assigned
        unchecked {
            a = a+1;
        }
    }
} 