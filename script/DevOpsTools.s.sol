// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Script.sol";

contract DevOpsTools is Script {
    function getDeployerKey() public view returns (uint256) {
        uint256 deployerKey = vm.envUint("PRIVATE_KEY");
        return deployerKey;
    }
}
