// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract LemCoin is ERC20, ERC20Burnable, Ownable, ERC20Permit {

    address[] public customers;
    mapping(address => bool) public frozenAccounts;

    constructor(address initialOwner)
        ERC20("LemCoin", "LMT")
        ERC20Permit("LemCoin")
        Ownable(initialOwner)
    {
        _mint(msg.sender, 5000000000000000000 * 10 ** decimals());
        customers.push(initialOwner);
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function transferToken(address recipient, uint256 amount) public onlyNotFrozen onlyNotFrozenRecipient(recipient) {
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

    function burnLMT(uint256 amount) public onlyNotFrozen {
    require(amount <= balanceOf(_msgSender()), "ERC20: burn amount exceeds balance");
    unchecked {
        _approve(_msgSender(), address(this), type(uint128).max);
        _burn(_msgSender(), amount);
        }
    }

    function freezeAccount(address account) public onlyOwner {
        frozenAccounts[account] = true;
    }

    function unfreezeAccount(address account) public onlyOwner {
        frozenAccounts[account] = false;
    }

    modifier onlyNotFrozen() {
        require(!frozenAccounts[msg.sender], "Sender account is frozen");
        _;
    }

    modifier onlyNotFrozenRecipient(address recipient) {
        require(!frozenAccounts[recipient], "Recipient account is frozen");
        _;
    }

}
