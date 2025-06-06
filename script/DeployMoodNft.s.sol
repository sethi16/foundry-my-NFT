//SPDX-LICENSE-IDENTIFIER: MIT
pragma solidity ^0.8.18;
import {Script} from "forge-std/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {console} from "forge-std/console.sol";
import  "@openzeppelin/contracts/utils/Base64.sol"; // Importing Base64 for encoding SVG to image URL

contract DeployMoodNft is Script {

    function run() public returns(MoodNft) {
        string memory SvgHappy = vm.readFile("./DynamicPic/Happy.svg");
        string memory SvgSad  = vm.readFile("./DynamicPic/Sad.svg");
        // check remapping for this cheatcode, 6th & 7th
        vm.startBroadcast();
        MoodNft moodNft = new MoodNft(svgToImageUrl(SvgHappy), svgToImageUrl(SvgSad));
        vm.stopBroadcast();
        return moodNft;
    

    }
    function svgToImageUrl(string memory svg) public pure returns (string memory){
        string memory prefiSvgImage = "data:image/svg+xml;base64,";
        string memory SvgUrlImage = (Base64.encode(bytes(abi.encodePacked(svg))));
        return string(abi.encodePacked(prefiSvgImage, SvgUrlImage));
// abi.encodePacked(arg); also helps in concatenating strings
    }
}