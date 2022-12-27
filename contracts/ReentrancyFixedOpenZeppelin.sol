// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 < 0.9.0;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract ReentrancyFixedOpenZeppelin is ReentrancyGuard {
    
    mapping(address => uint) public balances;

    // deposit: Allows users to deposit some funds & increments their amount
    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    // withdraw: Allows users to withdraw their deposits. Reentrancy bug fixed due to OpenZeppelin nonReentrant modifier however Check Effect Interaction pattern should still be applied to your functions as best practice.
    function withdraw() external nonReentrant {
        uint bal = balances[msg.sender];
        require(bal > 0);

        (bool s, ) = msg.sender.call{value: bal}("");
        require(s, "Failed withdraw");

        balances[msg.sender] = 0;
    }

}