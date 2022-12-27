# Reentrancy Attack Hack
Reentrancy Attacks occur when a contract function that sends assets to an external caller does not follow the Check Effects Interaction pattern. 

# CEI
Check Effects Interaction (CEI) coding pattern is a best practice in solidity that requires function code to be written in an order so that first code checks are performed e.g "require" statements, then contract state variables are updated, lasty funds/assets are transferred.

# Exploit
If CEI is not followed then Attacker contracts can have receive/fallback functions implemented that recursively call a contracts function to keep sending them assets/funds until a contract is drained or assets are no longer available.
Before solidity 0.6 a fallback function was used to exploit reentrancy attacks with funds however after solidity 0.6 you only need a receive function to perform the exploit.

# Fix
In order to prevent reentrancy attacks a contract function just needs to implement CEI coding practice. A contract function can also import OpenZeppelins ReentrancyGuard contract and apply the nonReentrant modifier. 
It should be noted that if your contract function already follows CEI then using the nonReentrant modifier from OpenZeppelin is not needed.

# ReentrancyExists.sol
Simple deposit/withdraw contract that contains the reentrancy bug.
# ReentrancyAttacker.sol
Attacker contract that uses "receive" to exploit the reentrancy bug inside ReentrancyExists.sol

# ReentrancyFixed.sol
This is the ReentrancyExists.sol contract but the reentrancy bug is fixed using CEI pattern.

# ReentrancyFixedOpenZeppelin.sol
This is the ReentrancyExists.sol contract but the reentrancy bug is fixed using OpenZeppelins ReentrancyGuard contract. Note that this fix does not have CEI applied, this is to show that the nonReentrant modifier works, however by default developers should be using the CEI pattern.