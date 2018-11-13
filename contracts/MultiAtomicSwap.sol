pragma solidity ^0.4.24;

contract MultiAtomicSwap {

    address sender;
    uint256 createdAt;

    struct Output {
        uint256 value;
        bytes32 hash;
    }

    mapping(address => Output) outputs;

    constructor (address[] _recipients, uint256[] _values, bytes32[] _hashes) public payable {
        require(_recipients.length == _values.length);
        require(_recipients.length == _hashes.length);

        uint256 length = _recipients.length;
        uint256 sum = 0;

        for (uint256 i = 0; i < length; i++) {
            sum += _values[i];
        }

        require(sum == msg.value);

        sender = msg.sender;
        createdAt = now;

        for (i = 0; i < length; i++) {
            address recipient = _recipients[i];

            outputs[recipient] = Output(_values[i], _hashes[i]);
        }
    }

    function refund() public {
        require(msg.sender == sender);
        require(now > createdAt + 1 hours);

        sender.transfer(address(this).balance);

        selfdestruct(msg.sender);
    }

    function withdraw(bytes32 _secret) public {
        uint256 value = outputs[msg.sender].value;
        require(value > 0);
        require(outputs[msg.sender].hash == sha256(abi.encodePacked(_secret)));

        delete outputs[msg.sender];

        msg.sender.transfer(value);

        if(address(this).balance == 0) {
            selfdestruct(msg.sender);
        }
        // else {
        //     msg.sender.transfer(value);
        // }
    }
}
