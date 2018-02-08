pragma solidity ^0.4.18;

contract Escrow {
    address public creator;
    address public arbitrator;
    address public buyer;
    address public seller;
    //have buyer or seller initiated dispute
    bool private buyerCancel;
    bool private sellerCancel;

    event LogMessage(string msg);

    modifier onlyBuyer() {
        require(msg.sender == buyer);
        _;
    }

    modifier onlyArbitrator() {
        require(msg.sender == arbitrator);
        _;
    }

    function Escrow(address _arbitrator, address _buyer, address _seller) public {
        require(_arbitrator!=0x0 && _buyer!=0x0 && _seller!=0x0);
        creator = msg.sender;
        arbitrator = _arbitrator;
        buyer = _buyer;
        seller = _seller;
        buyerCancel = false;
        sellerCancel = false;
    }

    function fundEscrow() public payable onlyBuyer {
        //only buyer can fund       
        //msg.value is automatically set as the balance of this contract
    }

    function approvePayment() public onlyBuyer {
        //only buyer can approve, and no disputes
        require(!buyerCancel && !sellerCancel);

        payout();
    }

    function mediate(address inFavorOf) public onlyArbitrator {
        require(inFavorOf == buyer || inFavorOf == seller);

        //arbitrator fee 1%
        arbitrator.transfer(this.balance/100);

        if (inFavorOf == buyer) {
            refund();
        } else if (inFavorOf == seller) {
            payout();
        }
    }

    function dispute() public {
        if (msg.sender == buyer) {
            buyerCancel = true;
            LogMessage("cancelled by buyer");
        }

        if (msg.sender == seller) {
            sellerCancel = true;
            LogMessage("cancelled by seller");
        }

        //check if need to refund
        if (buyerCancel && sellerCancel) {
            refund();            
        }
    }

    function hasbuyerDispute() public view returns (bool) {
        return buyerCancel;
    }

    function hassellerDispute() public view returns (bool) {
        return sellerCancel;
    }

    function refund() private {
        LogMessage("refunding balance to buyer");
        buyer.transfer(this.balance);
        //clear out disputes
        buyerCancel = false;
        sellerCancel = false;
    }

    function payout() private {
        //send fee 1% to creator
        creator.transfer(this.balance/100);

        //remaining to seller
        seller.transfer(this.balance);
    }
}