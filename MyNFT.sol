// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract MyNFT is ERC721("Guitars", "GTRS"), Ownable {
    
    uint256 tokenCounter;
    uint256 public price = 1000000000000000000;
    uint256 public MAX_TOKENS = 1000; // maximum supply
    string public baseURI = "https://gateway.pinata.cloud/ipfs/QmbU95CGaKiTnNbwguE54eShS4hFS77FqN971wxkeMyoJ8/";
    
    using Strings for uint256;
    
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual override(ERC721) {
        super._beforeTokenTransfer(from, to, tokenId);
    }
    
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721) returns (bool) {
        return interfaceId == type(IERC721Enumerable).interfaceId || super.supportsInterface(interfaceId);
    }
    
    function _baseURI() internal view virtual override(ERC721) returns (string memory) {
        return baseURI;
    }
    
    function mint() public payable {
        require(tokenCounter < MAX_TOKENS, "ERC721: Max supply");
        require(msg.value == price, "The price of the NFT is 0.01 AVAX");
        _safeMint(_msgSender(), tokenCounter);
        tokenCounter = tokenCounter + 1;
    }
    
    function withdraw() onlyOwner external {
        payable(owner()).transfer(address(this).balance);
    }
}