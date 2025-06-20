//SPDX-LICENSE-IDENTIFIER: MIT
pragma solidity ^0.8.18;
import {Script} from "forge-std/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {console} from "forge-std/console.sol";
import  "@openzeppelin/contracts/utils/Base64.sol"; // Importing Base64 for encoding SVG to image URL

contract DeployMoodNft is Script {

    function run() public returns(MoodNft) {
// When we read File code it's type is normal stirng not base, for base we need to convert
        string memory SvgHappy = vm.readFile("./DynamicPic/Happy.svg");
        string memory SvgSad  = vm.readFile("./DynamicPic/Sad.svg");
        // check remapping for this cheatcode, 6th & 7th
        vm.startBroadcast();
        MoodNft moodNft = new MoodNft(svgToImageUrl(SvgHappy), svgToImageUrl(SvgSad));
        vm.stopBroadcast();
        return moodNft;
    }
    // Remember, Otherthan than src file, pure is only used when we are doing calculation here we have done concatenation
    // | Variable |                      | What it is |                  | Type   |
| ------------------------------ | ------------------------------------- | ------ |
| `prefiSvgImage`                | Normal string prefix                  | string |
| `abi.encodePacked(svg)`        | Converts string to bytes              | bytes  |
| `Base64.encode(...)`           | Converts bytes to base64 string       | string |
| `abi.encodePacked(str1, str2)` | Concatenates both                     | bytes  |
| `string(...)`                  | Converts final bytes into full string | string |


    function svgToImageUrl(string memory svg) public pure returns (string memory){
        string memory prefiSvgImage = "data:image/svg+xml;base64,";
// "data:image/svg+xml;base64," stores the image itself (an SVG image) encoded as a Base64 string
        string memory SvgUrlImage = (Base64.encode(abi.encodePacked(svg)));
//Base64.encode helps to encode into base64 string different from normal string it is like 'WRRJGISHGSRSIHNSFIJEDSJSID'
        return string(abi.encodePacked(prefiSvgImage, SvgUrlImage));
// abi.encodePacked(arg); also helps in concatenating strings
    }
}
