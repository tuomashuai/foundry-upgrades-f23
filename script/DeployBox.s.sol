// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract DeployBox is Script {
    function run() external returns (address) {
        address boxV1 = deployBox();
        return boxV1;
    }

    function deployBox() public returns (address) {
        vm.startBroadcast();
        BoxV1 boxV1 = new BoxV1();

        ERC1967Proxy proxy = new ERC1967Proxy(
            address(boxV1),
            abi.encodeWithSelector(BoxV1.initialize.selector, msg.sender)
        );
        vm.stopBroadcast();
        console.log("BoxV1 implementation address:", address(boxV1));
        console.log("BoxV1 proxy address:", address(proxy));
        return address(proxy);
    }
}
