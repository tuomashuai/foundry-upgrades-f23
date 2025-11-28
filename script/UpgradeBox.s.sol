//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {BoxV2} from "../src/BoxV2.sol";
import {BoxV1} from "../src/BoxV1.sol";

contract UpgradeBox is Script {
    function run() external returns (address) {
        //获取最近部署的代理合约地址
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "ERC1967Proxy",
            block.chainid
        );

        vm.startBroadcast();
        //获取要升级的新实现合约地址
        BoxV2 boxV2 = new BoxV2();
        vm.stopBroadcast();
        address proxyAddress = upgradeBox(mostRecentlyDeployed, address(boxV2));

        return proxyAddress;
    }

    function upgradeBox(
        address proxyAddress,
        address newBox
    ) public returns (address) {
        vm.startBroadcast();
        //获取代理合约实例
        BoxV1 proxy = BoxV1(proxyAddress);
        //通过代理合约升级到新的实现合约
        proxy.upgradeToAndCall(address(newBox), "");
        vm.stopBroadcast();
        return address(proxy);
    }
}
