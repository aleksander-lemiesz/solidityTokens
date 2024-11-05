// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import "@openzeppelin/contracts@5.1.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@5.1.0/access/Ownable.sol";

contract LemCoin is ERC721, Ownable {
    constructor(address initialOwner)
        ERC721("LemCoin", "LMT")
        Ownable(initialOwner)
    {}

    function safeMint(address to, uint256 tokenId) public onlyOwner {
        _safeMint(to, tokenId);
    }

    function transferToken(address recipient, uint256 assetId) public {
        _transfer(msg.sender, recipient, assetId);
    }

    function getAssetOwner(uint256 assetId) public view returns (address) {
        return ownerOf(assetId);
    }
}
