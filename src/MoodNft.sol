//SPDX-LICENSE-IDENTIFIER: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

enum Mood{
    Happy, // 0
    Sad    // 1
}

contract MoodNft is ERC721{
    error ERC721NotExist();
    error MoodNft__CantFlipMoodIfNotOwner();
    mapping(uint256 => Mood) public s_tokenIdToMood;

      event CreatedNFT(uint256 indexed tokenId);
    uint256 public s_tokenCounter;
    string public Happy_Svi_Url;
    string public Sad_Svi_Url;

constructor(string memory happySviUrl, string memory sadSviUrl) ERC721("MoodNFT", "MNFT"){
    s_tokenCounter = 0;
    Happy_Svi_Url = happySviUrl;
    Sad_Svi_Url = sadSviUrl;
    
}
    function mintNft() public {
      uint256  tokenId = s_tokenCounter;
        _safeMint(msg.sender, tokenId);
        s_tokenCounter++;
        emit CreatedNFT(tokenId );
    }
    function _baseURI() internal view virtual override returns (string memory) {
        return "data:application/json;base64,";
// Other than storing the image data, NFTs also need to store metadata about the whole NFT, such as:
//Name of the NFT
//Description
//Attributes or properties (like color, rarity, stats)
//The image link or data itself

    } 
       function flipMood(uint256 tokenId) public {
        if (getApproved(tokenId) != msg.sender && ownerOf(tokenId) != msg.sender) {
            revert MoodNft__CantFlipMoodIfNotOwner();
        }

        if (s_tokenIdToMood[tokenId] == Mood.Happy) {
            s_tokenIdToMood[tokenId] = Mood.Sad;
        } else {
            s_tokenIdToMood[tokenId] = Mood.Happy;
        }
    }


      function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        if(ownerOf(tokenId) == address(0)){
            revert ERC721NotExist();
        }
        string memory imageURI = Happy_Svi_Url;
        if(s_tokenIdToMood[tokenId] == Mood.Sad){
            imageURI = Sad_Svi_Url; 
}
// In the return, abi.encodePacked is used for concat & converting to bytes, can do both tasks in a single step
//  Base64.encode convert bytes to base64 string
// normal string ='HelloWorld'
// Base64 string ='PEJFDIFISJFISJIRSNDSKLNSIFLKFIWRKNSFDGNF' this stirng hold the image data
        return string
        (abi.encodePacked(_baseURI(),
         Base64.encode(abi.encodePacked( '{"name":"',
                            name(), // You can add whatever name here
                            '", "description":"An NFT that reflects the mood of the owner, 100% on Chain!", ',
                            '"attributes": [{"trait_type": "moodiness", "value": 100}], "image":"',
                            imageURI,
                            '"}'
                            )
             )
        )
    );
                            

    }
}



