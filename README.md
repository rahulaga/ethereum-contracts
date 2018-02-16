# Ethereum Contracts

Using Truffle and Solidity.

## Escrow

NOTE: this example does not use the best-practice of "withdrawing funds" and needs to be updated.

All commands in `$truffle console`

Migrate contracts
> migrate --reset

List all accounts
> web3.eth.accounts

Account at index 2
> web3.eth.accounts[2]

Balance of an address
> web3.fromWei(web3.eth.getBalance("0xa509542ada3196a38bd6fd03b253547ee09220c4"),"ether")

Set accounts to use, arbitrator, buyer, seller
> a = web3.eth.accounts[0]
'0x627306090abab3a6e1400e9345bc60c78a8bef57'

> b = web3.eth.accounts[1]
'0xf17f52151ebef6c7334fad080c5704d77216b732'

> s = web3.eth.accounts[2]
'0xc5fdf4076b8f3a5357c5e395ab970b5b54098fef'

> var escrow;
> Escrow.new(a,b,s).then(function(instance){escrow=instance;});

Show address
> escrow.address
    
Show balance
> web3.fromWei(web3.eth.getBalance(escrow.address),"ether").toString()

Fund it
> var funding
> Escrow.at(escrow.address).fundEscrow({from:b,value:web3.toWei(10,"ether")}).then(function(instance){funding=instance;})

Approve payment
> Escrow.at(escrow.address).approvePayment({from:b})

Call example
> Escrow.at(escrow.address).buyer.call()

Dispute
> Escrow.at(escrow.address).hasClientDispute()
> Escrow.at(escrow.address).hasFreelancerDispute()

Create dispute
> var dispute
> Escrow.at(escrow.address).dispute({from:s}).then(function(instance){dispute=instance;})
Escrow.at(escrow.address).dispute({from:b}).then(function(instance){dispute=instance;})

Mediate
> var ar
> Escrow.at(escrow.address).mediate(b,{from:a}).then(function(instance){ar=instance;})
