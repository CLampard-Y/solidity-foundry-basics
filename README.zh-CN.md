# Solidity Foundry Simple Storage

[![CI](https://github.com/CLampard-Y/solidity-foundry-basics/actions/workflows/test.yml/badge.svg)](https://github.com/CLampard-Y/solidity-foundry-basics/actions/workflows/test.yml)
[![Built with Foundry](https://img.shields.io/badge/Built%20with-Foundry-FFDB1F.svg)](https://book.getfoundry.sh/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

[English](./README.md) | 中文

**Cyfrin Updraft Foundry Fundamentals - Section 1** 项目

## 项目概述

- 实现了简单的存储和读取功能
- 包含结构体、数组、映射等 Solidity 基础语法
- `store()`、`retrieve()`、`addPerson()` 三个核心函数
- 使用 Foundry 完整开发流程（开发、编译、测试、本地部署、测试网部署）

## 合约功能

| 函数 | 类型 | 说明 |
| --- | --- | --- |
| `store(uint256)` | 写入 | 更新合约中保存的 favorite number |
| `retrieve()` | 读取 | 返回当前保存的 favorite number |
| `addPerson(string,uint256)` | 写入 | 添加一个 `Person` 到数组，并更新名字到数字的映射 |
| `listOfPeople(uint256)` | 读取 | 通过数组索引查询已添加的 `Person` |
| `nameToFavoriteNumber(string)` | 读取 | 通过名字查询对应的 favorite number |

## 技术栈

- Solidity `^0.8.19` with Foundry `solc_version = "0.8.19"`
- Foundry (`forge`, `cast`, `anvil`)
- MetaMask + Rabby Wallet
- Sepolia 测试网

## 测试与验证

### 本地验证命令

```bash
forge fmt --check
forge build --sizes
forge test -vvv
```

### 测试覆盖

- `retrieve()` 初始返回值为 `0`
- `store(42)` 后，`retrieve()` 返回 `42`
- `addPerson("Alice", 7)` 后，`listOfPeople(0)` 返回正确的结构体数据
- `addPerson("Bob", 99)` 后，`nameToFavoriteNumber("Bob")` 返回 `99`

### 最新测试结果

```text
Ran 4 tests for test/SimpleStorageTest.t.sol:SimpleStorageTest
[PASS] testAddPersonStoresPersonInArray() (gas: 104477)
[PASS] testAddPersonUpdatesNameToFavoriteNumber() (gas: 99024)
[PASS] testRetrieveReturnsInitialValue() (gas: 7843)
[PASS] testStoreUpdatesFavoriteNumber() (gas: 29167)
Suite result: ok. 4 passed; 0 failed; 0 skipped

Ran 1 test suite: 4 tests passed, 0 failed, 0 skipped (4 total tests)
```

### 合约大小

`forge build --sizes` 输出：

| Contract | Runtime Size (B) | Initcode Size (B) | Runtime Margin (B) | Initcode Margin (B) |
| --- | ---: | ---: | ---: | ---: |
| `SimpleStorage` | 2,363 | 2,395 | 22,213 | 46,757 |

## 部署记录

### 本地 Anvil 部署

- 使用 `anvil` + `forge create` + `cast` 完成完整交互验证
- 已验证 `store(42)` -> `retrieve()` 返回 42

```bash
# 1. 启动本地链
anvil

# 2. 部署合约
forge create src/SimpleStorage.sol:SimpleStorage \
  --rpc-url http://127.0.0.1:8545 \
  --private-key <anvil-private-key> \
  --broadcast

# 3. 写入数据
cast send <contract-address> "store(uint256)" 42 \
  --rpc-url http://127.0.0.1:8545 \
  --private-key <anvil-private-key>

# 4. 读取数据
cast call <contract-address> "retrieve()(uint256)" \
  --rpc-url http://127.0.0.1:8545
```

### Sepolia 测试网部署

**合约地址**： `0x23F7fdB6A19aFf8016eFA181B3F639C56326CBf`

**交易链接**： [Sepolia Etherscan](https://sepolia.etherscan.io/tx/0x1db892ec7785e3a4ef376da26e3d566d3d954d08a6ee3853dee9d33b5bb52021)

**Gas Report**

| 操作 | Gas Used | 备注 |
| --- | ---: | --- |
| Contract Deployment | 562,679 | SimpleStorage.sol |
| Transaction Hash | [查看交易](https://sepolia.etherscan.io/tx/0x1db892ec7785e3a4ef376da26e3d566d3d954d08a6ee3853dee9d33b5bb52021) | 已确认 |
| Contract Address | `0x23F7fdB6A19aFf8016eFA181B3F639C56326CBf` | 已部署 |

- **Gas Price** ≈ 2 Gwei（当前测试网环境）
- 部署总成本极低（测试网免费测试）

## 如何在本地运行

### 环境配置

复制环境变量模板并填写自己的测试网配置：

```bash
cp .env.example .env
```

`.env` 文件已加入 `.gitignore`，不要提交真实私钥、RPC URL 密钥或 Etherscan API Key。

`.env.example` 字段说明：

| 字段 | 说明 |
| --- | --- |
| `SEPOLIA_RPC_URL` | Sepolia 测试网 RPC 地址，推荐使用自己的 Alchemy、Infura 或其他 RPC 服务 |
| `PRIVATE_KEY` | 测试钱包私钥，仅用于测试网部署，不要使用主钱包私钥 |
| `ETHERSCAN_API_KEY` | 可选，用于 Etherscan 合约验证 |

### 本地命令

```bash
# 安装依赖
forge install

# 格式检查
forge fmt --check

# 编译
forge build --sizes

# 测试
forge test -vvv
```

## 学习收获

- 掌握 Foundry 完整开发流程（compile -> test -> local deploy -> testnet deploy）
- 理解 RPC URL、JSON-RPC、cast 交互等核心概念
- 完成第一个可部署、可交互的 Solidity 合约

## 项目边界与说明

- 本项目为 Foundry Fundamentals Section 1 教学练习项目
- 重点是掌握 Solidity 基础语法、Foundry 测试、本地链部署、测试网部署和 cast 命令行交互
- 当前合约只实现基础存储与读取功能，未包含访问控制、事件日志、自定义错误或生产级安全设计
- 适合作为 Solidity + Foundry 入门展示项目，不适合直接用于生产环境

## 未来计划

- 在后续练习中实现 ERC-20 代币合约
- 增加更完整的测试、脚本化部署和合约验证流程
- 学习事件日志、错误处理、访问控制和常见安全模式
