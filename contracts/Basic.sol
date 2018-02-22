pragma solidity ^0.4.19;

//Some basic features like fallback method, payable, modifier, selfdestruct

contract Basic {
    address private creator;

    modifier onlyCreator() {
        require(msg.sender == creator);
        _;
    }

    function Basic() public {
        creator = msg.sender;
    }

    //fallback - keep all the money!
    function() public payable {}

    function kill() public onlyCreator {
        selfdestruct(creator);
    }
}