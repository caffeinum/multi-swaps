pragma solidity ^0.4.24;

contract AtomicSwap {

    bytes32 private secretHash;
    uint256 private createdAt;
    address private sender;
    address private recipient;

    constructor (address _recipient, bytes32 _hash) public payable {
        assembly {
            sstore(0, _hash)
            sstore(1, timestamp)
            sstore(2, origin)
            sstore(3, _recipient)
        }
    }

    function refund() public {
        assembly {
            if lt(timestamp, add(sload(1), 3600)) {
                stop()
            }

            selfdestruct(sload(2))
        }
    }

    function withdraw(bytes32 _secret) public {
        bytes32 _hash = sha256(abi.encodePacked(_secret));

        assembly {
            if not(eq(_hash, sload(0))) {
                stop()
            }

            selfdestruct(sload(3))
        }
    }
}
