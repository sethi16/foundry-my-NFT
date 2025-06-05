//SPDX-LICENSE-IDENTIFIER:MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
// When we inherit, from some contract, we need to pass the constructor value to it!
contract BasicNft is ERC721 {
    uint256 private s_tokenCounter;
    mapping(uint256 => string) private s_tokenIdToString;

    constructor() ERC721("BasicNFT", "BNFT"){
        s_tokenCounter = 0;
    }
    function mintNft(string memory tokenURI) public {
        s_tokenIdToString[s_tokenCounter] = tokenURI;
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++; 

    }
    function tokenURI(uint256 tokenId) public view override returns (string memory){
        // return s_tokenIdToString[tokenId];
        return "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";
 
    }



}