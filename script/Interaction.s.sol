// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {MoodNft} from "../src/MoodNft.sol";
// Installed fundry-devops package for DevOpsTools
// Run `forge install foundry-devops` to install the package
// Remapping tells the forge where to find the imported data from src, script, test files!
import {console} from "forge-std/console.sol";

contract Interaction is Script {
    string public constant PUG = "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function run() public {
        address deployment = DevOpsTools.get_most_recent_deployment("BasicNft", block.chainid);
        setUp(deployment);
    }

    function setUp(address deployment) public {
        vm.startBroadcast();
        BasicNft(deployment).mintNft(PUG);
        vm.stopBroadcast();
        console.log("Minted NFT with tokenURI: %s", PUG);
    }
}
contract InteractionMood is Script{
    function run() public {
        address deployment = DevOpsTools.get_most_recent_deployment("MoodNft", block.chainid);
        setUp(deployment);
    }
    function setUp(address deployment) public{
        vm.startBroadcast();
        MoodNft(deployment).mintNft();
        vm.stopBroadcast();
    }
}
contract FlipMoodNft is Script{
    uint256 public constant tokenId = 1; // Assuming we want to flip the mood of the NFT with tokenId 1
    function run() public {
        address deployment = DevOpsTools.get_most_recent_deployment("MoodNft", block.chainid);
        setUp(deployment);
    }
    function setUp(address deployment) public{
        vm.startBroadcast();
        MoodNft(deployment).flipMood(tokenId);
        vm.stopBroadcast();
        console.log("Flipped Mood NFT with tokenId: %s", MoodNft(deployment).tokenURI(tokenId));

    }
}
// foundry-brownie for Pricefeed(AggreatorV3Interface)
// foundry-devops for DevOpsTools, check for patrick for the command
// foundry-std for Script, Test and console
// For every import from  outside need to install the package