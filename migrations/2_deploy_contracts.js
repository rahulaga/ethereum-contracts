var Basic = artifacts.require("Basic");
var Escrow = artifacts.require("Escrow");

module.exports = function(deployer) {
    deployer.deploy(Basic);
    deployer.deploy(Escrow, 1,1,1);
};