var Escrow = artifacts.require("Escrow");

module.exports = function(deployer) {
  deployer.deploy(Escrow, 1,1,1);
};