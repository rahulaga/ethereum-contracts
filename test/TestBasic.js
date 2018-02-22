var Basic = artifacts.require("Basic.sol");

contract('Basic', async function(accounts) {
    it("create kill contract", async function() {
        //created with account[0]
        let instance = await Basic.deployed();
        //console.log(instance);
        //let balance = instance.balance;
        assert.equal(web3.fromWei(web3.eth.getBalance(instance.address),"ether"), 0);

        //send some ether
        await instance.send(web3.toWei(1, "ether"));
        //send from specific account
        await instance.sendTransaction({from:accounts[1],value:web3.toWei(1,"ether")});
        assert.equal(web3.fromWei(web3.eth.getBalance(instance.address),"ether"), 2);

        //kill it
        var beforeBalance = web3.eth.getBalance(accounts[0]);
        console.log("balance before kill="+beforeBalance)
        await instance.kill({from:accounts[0]});
        var afterBalance = web3.eth.getBalance(accounts[0]);
        console.log("balance after kill="+afterBalance);
        assert.isTrue(afterBalance>beforeBalance);//not exactly plus 2 due to gas costs
    });
})
