//SPDX-LICENSE-IDENTIFIER: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {console} from "forge-std/console.sol";
contract Deploy is Script{
     function run()  external returns(BasicNft){
        // return BasicNft, eventhough we are returning its variable but need to mention the contract name!
         vm.startBroadcast();
            BasicNft basicNft = new BasicNft();
            vm.stopBroadcast();
            return basicNft;
     }
}