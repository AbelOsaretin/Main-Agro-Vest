// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {DAO} from "../src/DAO.sol";
import {Token} from "../src/Token.sol";

contract CounterTest is Test {
    Token public token;
    DAO public dao;

    address owner = makeAddr("owner");

    function setUp() public {
        token = new Token(owner);
        dao = new DAO(address(token));
    }

    function test_Token_Lock() public {
        vm.startPrank(owner);
        token.approve(address(dao), 10000);
        dao.lockTokens(10000);
    }

    function test_Token_Unlock() public {
        test_Token_Lock();
        dao.getTokenBalance();
        dao.unlockTokens();
        dao.getTokenBalance();
    }

    function test_Proposal() public {
        vm.startPrank(owner);
        dao.proposal("Abel", "description");
        dao.getSingleProposal(0);
        dao.getAllProposals();
    }

    function test_Vote_Proposal() public {
        test_Token_Lock();
        dao.proposal("Abel", "description");
        dao.voteProposal(0);
    }

    function test_Tally_Votes() public {
        test_Vote_Proposal();
        dao.tallyVotes(0);
    }
}
