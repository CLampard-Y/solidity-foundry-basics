# Solidity Foundry Simple Storage

[![CI](https://github.com/CLampard-Y/solidity-foundry-basics/actions/workflows/test.yml/badge.svg)](https://github.com/CLampard-Y/solidity-foundry-basics/actions/workflows/test.yml)
[![Built with Foundry](https://img.shields.io/badge/Built%20with-Foundry-FFDB1F.svg)](https://book.getfoundry.sh/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

English | [中文](./README.zh-CN.md)

A Solidity and Foundry fundamentals project based on **Cyfrin Updraft Foundry Fundamentals - Section 1**.

This repository demonstrates a complete beginner-level smart contract workflow: contract development, unit testing, local deployment with Anvil, command-line contract interaction with cast, and Sepolia testnet deployment.

## Overview

- Implements a basic storage contract for writing and reading a favorite number.
- Covers core Solidity concepts including state variables, structs, dynamic arrays, mappings, visibility, and memory data location.
- Provides three primary functions: `store()`, `retrieve()`, and `addPerson()`.
- Uses Foundry for formatting, compilation, unit testing, local deployment, and testnet deployment.

## Contract Interface

| Function | Type | Description |
| --- | --- | --- |
| `store(uint256)` | Write | Updates the stored favorite number |
| `retrieve()` | Read | Returns the currently stored favorite number |
| `addPerson(string,uint256)` | Write | Adds a `Person` record and updates the name-to-number mapping |
| `listOfPeople(uint256)` | Read | Returns a `Person` by array index via the public array getter |
| `nameToFavoriteNumber(string)` | Read | Returns the favorite number associated with a name |

## Tech Stack

- Solidity `^0.8.19` with Foundry `solc_version = "0.8.19"`
- Foundry (`forge`, `cast`, `anvil`)
- MetaMask and Rabby Wallet
- Sepolia testnet

## Testing and Verification

### Local Verification Commands

```bash
forge fmt --check
forge build --sizes
forge test -vvv
```

### Test Coverage

- `retrieve()` returns the initial value `0`.
- `store(42)` updates the stored value, and `retrieve()` returns `42`.
- `addPerson("Alice", 7)` stores the expected `Person` data in `listOfPeople`.
- `addPerson("Bob", 99)` updates `nameToFavoriteNumber("Bob")` to `99`.

### Latest Test Result

```text
Ran 4 tests for test/SimpleStorageTest.t.sol:SimpleStorageTest
[PASS] testAddPersonStoresPersonInArray() (gas: 104477)
[PASS] testAddPersonUpdatesNameToFavoriteNumber() (gas: 99024)
[PASS] testRetrieveReturnsInitialValue() (gas: 7843)
[PASS] testStoreUpdatesFavoriteNumber() (gas: 29167)
Suite result: ok. 4 passed; 0 failed; 0 skipped

Ran 1 test suite: 4 tests passed, 0 failed, 0 skipped (4 total tests)
```

### Contract Size

Output from `forge build --sizes`:

| Contract | Runtime Size (B) | Initcode Size (B) | Runtime Margin (B) | Initcode Margin (B) |
| --- | ---: | ---: | ---: | ---: |
| `SimpleStorage` | 2,363 | 2,395 | 22,213 | 46,757 |

## Deployment Records

### Local Anvil Deployment

- Deployed and verified locally using `anvil`, `forge create`, and `cast`.
- Verified that `store(42)` updates the contract state and `retrieve()` returns `42`.

```bash
# 1. Start a local chain
anvil

# 2. Deploy the contract
forge create src/SimpleStorage.sol:SimpleStorage \
  --rpc-url http://127.0.0.1:8545 \
  --private-key <anvil-private-key> \
  --broadcast

# 3. Send a state-changing transaction
cast send <contract-address> "store(uint256)" 42 \
  --rpc-url http://127.0.0.1:8545 \
  --private-key <anvil-private-key>

# 4. Read the stored value
cast call <contract-address> "retrieve()(uint256)" \
  --rpc-url http://127.0.0.1:8545
```

### Sepolia Testnet Deployment

**Contract Address:** `0x23F7fdB6A19aFf8016eFA181B3F639C56326CBf`

**Deployment Transaction:** [Sepolia Etherscan](https://sepolia.etherscan.io/tx/0x1db892ec7785e3a4ef376da26e3d566d3d954d08a6ee3853dee9d33b5bb52021)

**Gas Report**

| Item | Value | Notes |
| --- | ---: | --- |
| Contract Deployment | 562,679 gas | SimpleStorage.sol |
| Transaction Hash | [`0x1db8...2021`](https://sepolia.etherscan.io/tx/0x1db892ec7785e3a4ef376da26e3d566d3d954d08a6ee3853dee9d33b5bb52021) | Confirmed |
| Contract Address | `0x23F7fdB6A19aFf8016eFA181B3F639C56326CBf` | Deployed on Sepolia |

- **Gas Price:** approximately 2 Gwei at deployment time.
- Deployment was performed on Sepolia testnet using test ETH.

## Getting Started

### Environment Setup

Copy the environment variable template and fill in your own testnet configuration:

```bash
cp .env.example .env
```

The `.env` file is ignored by Git. Do not commit real private keys, RPC provider secrets, or Etherscan API keys.

`.env.example` fields:

| Variable | Description |
| --- | --- |
| `SEPOLIA_RPC_URL` | Sepolia RPC endpoint. Use your own Alchemy, Infura, or other RPC provider endpoint |
| `PRIVATE_KEY` | Test wallet private key for testnet deployment only. Do not use a main wallet key |
| `ETHERSCAN_API_KEY` | Optional API key for Etherscan contract verification |

### Local Commands

```bash
# Install dependencies
forge install

# Check formatting
forge fmt --check

# Compile and show contract sizes
forge build --sizes

# Run unit tests
forge test -vvv
```

## Learning Outcomes

- Completed the basic Foundry workflow: compile, test, local deployment, and testnet deployment.
- Practiced JSON-RPC concepts, RPC URLs, and command-line contract interaction with `cast`.
- Built and deployed a minimal Solidity smart contract with a reproducible development workflow.

## Project Scope

- This is a **Foundry Fundamentals Section 1** learning project.
- The goal is to demonstrate Solidity basics, Foundry testing, local chain deployment, testnet deployment, and CLI-based contract interaction.
- The contract intentionally implements only basic storage and retrieval logic.
- This project does not include access control, events, custom errors, production security patterns, or a production-ready contract architecture.
- It is suitable as an entry-level Solidity and Foundry demonstration project, not as production smart contract code.

## Roadmap

- Implement an ERC-20 token contract in a follow-up project.
- Add script-based deployment and contract verification workflows.
- Study events, custom errors, access control, and common smart contract security patterns.
