// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "forge-std/Test.sol";

import {DeployBox} from "../script/DeployBox.s.sol";
import {UpgradeBox} from "../script/UpgradeBox.s.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";

contract DeployAndUpgardeTest is Test {
    DeployBox deployer;
    UpgradeBox upgrader;
    address public Owner = makeAddr("Owner");

    address proxyAddress;

    function setUp() public {
        deployer = new DeployBox();
        upgrader = new UpgradeBox();

        proxyAddress = deployer.run();
    }

    function testUpgrade() public {
        BoxV2 boxV2 = new BoxV2();
        upgrader.upgradeBox(proxyAddress, address(boxV2));

        uint256 expectedValue = 2;

        BoxV2(proxyAddress).setNumber(7);

        //校验升级后的版本号是否为V2
        assertEq(BoxV2(proxyAddress).getVersion(), "V2");
        //校验升级后新功能是否可用
        assertEq(BoxV2(proxyAddress).getNumber(), 7);
    }

    function testProxyStartsAsBoxV1() public {
        vm.expectRevert();
        BoxV2(proxyAddress).setNumber(7);
        //校验初始版本号是否为V1
        assertEq(BoxV1(proxyAddress).getVersion(), "V1");
    }
}
