pragma solidity ^0.4.24;

contract AtomicSwap {

    bytes32 private secretHash;
    uint256 private createdAt;
    address private sender;
    address private recipient;

    constructor (address _recipient, bytes32 _hash) public payable {
        secretHash = _hash;
        createdAt = now;
        recipient = _recipient;
        sender = msg.sender;
    }

    function refund() public {
        require(sender == msg.sender);
        require(now > createdAt + 1 hours);

        selfdestruct(msg.sender);
    }

    function withdraw(bytes32 _secret) public {
        bytes32 _hash = sha256(abi.encodePacked(_secret));

        require(_hash == secretHash);
        require(recipient == msg.sender);

        selfdestruct(msg.sender);
    }
}
