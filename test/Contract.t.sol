// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import {ContractFactory} from "src/ContractFactory.sol";

contract TestContract is Test {
    ContractFactory factory;

    function setUp() public {
        factory = new ContractFactory();
    }

    function testCreate2Address() public {
        address createdContract = factory.createContract();
        address addr = factory.getContractAddress();
        assertEq(addr, createdContract);
    }
}
