// SPDX-License-Identifier: APACHE
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

/// @custom:security-contact odafe@mowblox.com
contract MentorToken is ERC20, ERC20Burnable, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    constructor(
        address defaultAdmin,
        address minter
    ) ERC20("Mentor Token", "MENT") {
        _grantRole(DEFAULT_ADMIN_ROLE, defaultAdmin);
        _grantRole(MINTER_ROLE, minter);
    }

    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        _mint(to, amount);
    }

    function burnAsMinter(
        address account,
        uint256 value
    ) public onlyRole(MINTER_ROLE) {
        // @Jovells suggest that we check back in the Marketplace Contract to see if downvote has actually happened.
        // @mickeymond thinks that since we are not doing it for minting, why do that for burning?
        // We can put any extra validation checks here if we want to before burning happens.
        _burn(account, value);
    }

    function decimals() public view virtual override returns (uint8) {
        return 0;
    }
}