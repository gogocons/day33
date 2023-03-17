// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Token {
    string internalName;
    string internalSymbol;
    uint256 internalTotalSupply;
    uint256 internalDecimals;

    mapping(address => uint256) balances;

    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Approval(address indexed owner, address indexed spender, uint value);

    constructor(string memory _name, string memory _symbol, uint256 _totalSupply) {
        internalName = _name;
        internalSymbol = _symbol;
        internalTotalSupply = _totalSupply;
        // who am I in in solidity? who is the person who's deploying this contract?
        // we have access to a special property for this, msg.sender.
        balances[msg.sender] = internalTotalSupply;
        internalDecimals = 18;
    }

    function name() external view returns (string memory) {
        return internalName;
    }

    function symbol() external view returns (string memory) {
        return internalSymbol;
    }

    function decimals() external view returns (uint256) {
        return internalDecimals;
    }

    function totalSupply() external view returns (uint256) {
        return internalTotalSupply;
    }

    function balanceOf(address user) public view returns(uint256) {
        return balances[user];
    }

    function transfer(address to, uint256 amount) public returns(bool) {
        // couple things we want to do here.
        // lets start off with defensive programming and THEN get to the actual transfer.

        // 1. does the user have enough tokens to send the amount they want?
        require(balances[msg.sender] >= amount, "user does not have enough to send");

        // 2. we need to REDUCE the amount in the balances mapping, by the amount being sent.
        balances[msg.sender] -= amount;

        // 3. we need to INCREASE the amount in the balances mapping for the TO address, by the amount being sent.
        balances[to] += amount;

        emit Transfer(msg.sender, to, amount);

        return true;
    }

    // ignore allowance, approve, transferFrom
    function allowance(address owner, address spender) external view returns (uint) {
        return 0;
    }

    function approve(address spender, uint amount) external returns (bool) {
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool) {
        return false;
    }
}