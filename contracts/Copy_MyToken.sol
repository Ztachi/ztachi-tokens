// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC20, ERC20Permit, Ownable {
    constructor(uint256 initialSupply)
        ERC20("MyToken", "MTK")
        ERC20Permit("MyToken")
    {
        uint256 deployerAllocation = initialSupply / 2; // 假设给部署者分配50%
        uint256 contractAllocation = initialSupply - deployerAllocation; // 剩余的50%保留在合约中

        _mint(msg.sender, deployerAllocation); // 给部署者分配代币
        _mint(address(this), contractAllocation); // 将剩余的代币保留在合约内
    }

    // 提取合约内的代币到拥有者账户
    function withdrawTokens(uint256 amount) public onlyOwner {
        require(
            balanceOf(address(this)) >= amount,
            "Insufficient balance in contract"
        );
        _transfer(address(this), msg.sender, amount);
    }
}
