// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 < 0.9.0;

contract ReentrancyFixed {
    
    mapping(address => uint) public balances;

    // deposit: Allows users to deposit some funds & increments their amount
    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    // withdraw: Allows users to withdraw their deposits. Reentrancy bug fixed due to Check Effects Interaction pattern.
    function withdraw() external {
        require(balances[msg.sender] > 0, "Empty balance");
        uint bal = balances[msg.sender];

        balances[msg.sender] = 0;

        (bool s, ) = msg.sender.call{value: bal}("");
        require(s, "Failed withdraw");
    }

}