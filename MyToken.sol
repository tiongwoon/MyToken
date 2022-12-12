// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts@4.8.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.8.0/access/Ownable.sol";
import "@openzeppelin/contracts@4.8.0/utils/Counters.sol";

contract MyToken is ERC721, Ownable {
    using Counters for Counters.Counter;
    uint8 totalNFTMinted; 

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("MyToken", "OTW") {
        //to make sure tokenId counter starts at 1
        _tokenIdCounter.increment();
    }

    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://QmPJw87hDmaWCxnAhdc6BnWJ7GCt6YWLqxE9FAj9mZAKjJ";
    }

    function safeMint(address to) public onlyOwner {
        require(totalNFTMinted <= 2, "No more NFTs left blud");
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        totalNFTMinted++;
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        _requireMinted(tokenId);
        string memory baseURI = _baseURI();
        return string(abi.encodePacked(baseURI, "/", Strings.toString(tokenId), ".json"));
    }
}
