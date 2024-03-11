// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ZtachiToken is ERC20, ERC20Burnable, ERC20Permit, Ownable {
    constructor(uint256 initialSupply)
        ERC20("ZtachiToken", "ZITK")
        ERC20Permit("ZtachiToken")
        Ownable(msg.sender)
    {
        uint256 deployerAllocation = initialSupply / 2; // 假设给部署者分配50%
        uint256 contractAllocation = initialSupply - deployerAllocation; // 剩余的50%保留在合约内

        _mint(msg.sender, deployerAllocation); // 给部署者分配代币
        _mint(address(this), contractAllocation); // 将剩余的代币保留在合约内
    }

    // 提取合约内的代币到指定账户
    function withdrawTokensTo(address to, uint256 amount) public onlyOwner {
        require(
            balanceOf(address(this)) >= amount,
            "Insufficient token balance in contract"
        );
        _transfer(address(this), to, amount);
    }

    // 查询合约内的代币余额
    function contractBalance() public view returns (uint256) {
        return balanceOf(address(this));
    }

    // 增加铸币功能
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}
