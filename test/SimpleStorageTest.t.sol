// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {SimpleStorage} from "../src/SimpleStorage.sol";

contract SimpleStorageTest is Test {
    SimpleStorage private simpleStorage;

    function setUp() public {
        simpleStorage = new SimpleStorage();
    }

    function testRetrieveReturnsInitialValue() public view {
        assertEq(simpleStorage.retrieve(), 0);
    }

    function testStoreUpdatesFavoriteNumber() public {
        simpleStorage.store(42);

        assertEq(simpleStorage.retrieve(), 42);
    }

    function testAddPersonStoresPersonInArray() public {
        simpleStorage.addPerson("Alice", 7);

        (uint256 favoriteNumber, string memory name) = simpleStorage.listOfPeople(0);

        assertEq(favoriteNumber, 7);
        assertEq(name, "Alice");
    }

    function testAddPersonUpdatesNameToFavoriteNumber() public {
        simpleStorage.addPerson("Bob", 99);

        assertEq(simpleStorage.nameToFavoriteNumber("Bob"), 99);
    }
}
