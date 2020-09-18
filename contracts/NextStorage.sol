// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract NextStorage {

    mapping(address => uint256) internal _balances;
    mapping(address => mapping(address => uint256)) internal _allowances;

    uint256 internal _totalSupply;

    string internal constant _name = "NEXT";
    string internal constant _symbol = "NEXT";
    uint8 internal constant _decimals = 18;
    uint256 internal constant _maxSupply = 30300000 ether;

    /**
     * @dev minting address for stack rewards
     **/
    address public mintingOwner;
    address public newMintingOwner;

    event MintingOwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );
}

