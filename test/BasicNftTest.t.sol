// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {Test} from "forge-std/Test.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {Deploy} from "../script/Deploy.s.sol";


contract BasicNftTest is Test{
    Deploy public deploy;
    BasicNft public basicNft;
    address public bob;
    address public alice;
    string public PUG = "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() external{
        bob = makeAddr("bob");
        alice = makeAddr("alice");
        deploy = new Deploy();
        basicNft = deploy.run();
        // Nothing else required, otherthan deploying the contract
    }
    function testNameIsCorrect() public view {
        string memory expectName = "BasicNFT";
        string memory actualName = basicNft.name();
        // string cant be compared, here i have comapred the hash of the string
        assertEq(keccak256(abi.encodePacked(expectName)),keccak256(abi.encodePacked(actualName)));
    }
    function testCanMintAndHaveBalance() public{
        vm.prank(bob);
        basicNft.mintNft(PUG);
      assert(basicNft.balanceOf(bob) == 1);
      // Here, I didn't assign any value, here balance is bob own's one NFT
    assert(keccak256(abi.encodePacked(PUG)) == keccak256(abi.encodePacked(basicNft.tokenURI(0))));

}
}