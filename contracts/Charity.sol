// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PbaCharity is Ownable {
    struct Charity {
        address account;
        string name;
        string description;
    }

    struct Donation {
        address donor;
        address token;
        uint256 amount;
        bool revealed;
    }

    mapping(address => Charity) public charities;
    mapping(bytes32 => Donation) public donations;
    mapping(address => uint256) public charityVotes;

    constructor() Ownable(msg.sender) {}

    function addCharity(
        address account,
        string memory name,
        string memory description
    ) public onlyOwner {
        charities[account] = Charity(account, name, description);
    }

    function donate(address token, uint256 amount, bytes32 voteHash) public payable {
        require(amount > 0, "Amount must be greater than 0");
        require(donations[voteHash].donor == address(0), "Commitment already used");

        if (token != address(0)) {
            // Transfer tokens to contract
            IERC20(token).transferFrom(msg.sender, address(this), amount);
        } else {
            // Transfer ether
            require(msg.value == amount, "Incorrect ether amount");
        }

        donations[voteHash] = Donation({
            donor: msg.sender,
            token: token,
            amount: amount,
            revealed: false
        });
    }

    function revealVote(address charity, string memory salt) public {
        require(
            keccak256(abi.encodePacked(charities[charity].name)) != keccak256(abi.encodePacked("")),
            "Charity does not exist"
        );

        bytes32 voteHash = keccak256(abi.encodePacked(charity, salt));
        Donation storage donation = donations[voteHash];

        require(donation.donor == msg.sender, "Not the donor");
        require(!donation.revealed, "Already revealed");

        donation.revealed = true;
        charityVotes[charity]++;

        if (donation.token != address(0)) {
            IERC20(donation.token).transfer(charity, donation.amount);
        } else {
            payable(charity).transfer(donation.amount);
        }
    }
}
