// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract BoxV2 is UUPSUpgradeable, Initializable, OwnableUpgradeable {
    uint256 internal number;

    //@custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize() public initializer {
        __Ownable_init(msg.sender); //初始化合约的所有者
    }

    function getNumber() public view returns (uint256) {
        return number;
    }

    function getVersion() public pure returns (string memory) {
        return "V2";
    }

    function setNumber(uint256 _number) public {
        number = _number;
    }

    function _authorizeUpgrade(address newImplementation) internal override {}
}
