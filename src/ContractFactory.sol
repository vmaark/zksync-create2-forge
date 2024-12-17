// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;
import {Contract} from "./Contract.sol";

contract ContractFactory {
    function createContract() public returns (address pair)  {
        bytes memory bytecode = type(Contract).creationCode;
        bytes32 salt = keccak256(abi.encodePacked(hex'01'));
        assembly {
            pair := create2(0, add(bytecode, 32), mload(bytecode), salt)
        }
    }

    function getContractAddress() public view returns (address) {
        return address(uint160(
            uint256(
                keccak256(
                    abi.encodePacked(
                        bytes32(0x2020dba91b30cc0006188af794c2fb30dd8520db7e2c088b7fc7c103c00ca494), // keccak256("zksyncCreate2")
                        bytes32(uint256(uint160(address(this)))), // sender
                        keccak256(abi.encodePacked(hex'01')), // salt
                        hex'010004df694643e2d7e17535f16c21e9d1698b06c2ef330166830639b23b7f43', // init code hash
                        bytes32(0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470) // constructor input hash: keccak256("")
                    )
                )
            )
        ));
    }
}
