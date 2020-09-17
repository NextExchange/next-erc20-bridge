// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
import "./StandardToken.sol";
import "./proxy/Upgradeable.sol";

interface NextInterFace {
    function initialize(
        address payable _ownerAccount
    ) external;
}

abstract contract Minter is StandardToken {
    /**
     * @dev modifier onlyMinter
     */
    modifier onlyMinter() {
        require(msg.sender == mintingOwner, "ERR_ONLY_MINTING_OWNER_ALLOWED");
        _;
    }

    function _transferMintingOwnership(address _whom) internal {
        emit MintingOwnershipTransferred(mintingOwner, _whom);
        mintingOwner = _whom;
    }

    /**
     * @dev transfer minting ownership
     * first we have owner as minter then we transfer
     * ownership to stack contract
     */
    function transferMintingOwnerShip(address _whom) external onlyOwner() returns (bool)
    {
        newMintingOwner = _whom;
        return true;
    }

    /**
     * @dev accept minting ownership
     */
    function acceptMintingOwnerShip() external returns (bool) {
        require(msg.sender == newMintingOwner, "ERR_ONLY_NEW_MINTING_OWNER");
        _transferMintingOwnership(newMintingOwner);
        newMintingOwner = address(0);
        return true;
    }

    /**
     * @dev mint Token for ERC20 bridge
     */
    function mintToken(address recipient, uint256 amount) external onlyMinter() returns (bool) {
        return _mint(recipient, amount);
    }

    /**
     * @dev burn Token for ERC20 bridge
     */
    function burnToken(address recipient, uint256 amount) external onlyMinter() returns (bool) {
        return _burn(recipient, amount);
    }

}

/**
 * @title NextToken
 * @dev Contract to create the NextToken
 **/
contract NextToken is Upgradeable, Minter, NextInterFace {
    function initialize(
        address payable ownerAccount
    ) public override {

        super.initialize();

        _transferOwnership(ownerAccount);
        _transferMintingOwnership(ownerAccount);

    }

    /**
     * @dev See {IERC20-transfer}.
     *
     * Requirements:
     *
     * - the caller must have a balance of at least `amount`.
     */
    function transfer(address recipient, uint256 amount)
        external
        virtual
        override
        returns (bool)
    {
        _transfer(msg.sender, recipient, amount);
        return true;
    }

    /**
     * @dev See {IERC20-transferFrom}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of {ERC20};
     *
     * Requirements:
     * - `sender` and `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     * - the caller must have allowance for ``sender``'s tokens of at least
     * `amount`.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external virtual override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(
            sender,
            msg.sender,
            _allowances[sender][msg.sender].safeSub(amount)
        );
        return true;
    }

    /**
     * @dev fallback is not accept any ether
     **/
    receive() external payable {
        revert();
    }
}
