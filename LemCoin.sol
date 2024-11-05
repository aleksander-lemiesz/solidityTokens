// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import "@openzeppelin/contracts@5.1.0/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@5.1.0/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts@5.1.0/access/Ownable.sol";

contract LemCoin is ERC20, ERC20Permit, Ownable {

    address[] public customers;

    constructor(address initialOwner)
        ERC20("LemCoin", "LMT")
        ERC20Permit("LemCoin")
        Ownable(initialOwner)
    {
        _mint(msg.sender, 5000000000000000000 * 10 ** decimals());
        customers.push(initialOwner);
    }

    function transferToken(address recipient, uint256 amount) public /*onlyOwner*/ {
        _transfer(msg.sender, recipient, amount);
        customers.push(recipient);
    }

    function getCustomerCount() public view returns (uint256) {
        return customers.length;
    }

    function getCustomers() public view returns (address[] memory) {
        return customers;
    }

    function getBalance(address customer) public view returns (uint256) {
        return balanceOf(customer);
    }

}
