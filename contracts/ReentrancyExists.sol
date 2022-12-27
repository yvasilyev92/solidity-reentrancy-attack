// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 < 0.9.0;

contract ReentrancyExists {
    
    mapping(address => uint) public balances;

    // deposit: Allows users to deposit some funds & increments their amount
    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    // withdraw: Allows users to withdraw their deposits. Contains reentrancy bug.
    function withdraw() external {
        uint bal = balances[msg.sender];
        require(bal > 0);

        (bool s, ) = msg.sender.call{value: bal}("");
        require(s, "Failed withdraw");

        balances[msg.sender] = 0;
    }

}