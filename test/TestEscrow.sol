pragma solidity ^0.4.18;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Escrow.sol";

contract TestEscrow {
    event log(string message);
    event log(uint message);
    
    function testEscrowCreate() public {
      Escrow escrow = Escrow(DeployedAddresses.Escrow());

      escrow.balance;
      log("balance");
      log(escrow.balance);

      //escrow.
      //Assert.equal(escrow.balance, 1, "Error");
    }

}