// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract PbaCharity is Ownable {
  struct Charity {
    address account;
    string name;
    string description;
  }

  mapping(address => Charity) public charities;
  mapping(address => uint256) public tokenBalances;

  constructor() Ownable(msg.sender) {}

  function addCharity(
    address account,
    string memory name,
    string memory description) public onlyOwner {
    charities[msg.sender] = Charity(account, name, description);
  }

  function donate(address charity, address token, uint256 amount) public payable {
    require(
      keccak256(abi.encodePacked(charities[charity].name)) != keccak256(abi.encodePacked("")),
      "Charity does not exist"
    );
    require(amount > 0, "Amount must be greater than 0");

    if (token != address(0)) {
      // Transfer tokens
      IERC20(token).transferFrom(msg.sender, charity, amount);
    } else {
      // Transfer ether
      tokenBalances[charity] += msg.value;
    }
  }
}
