pragma solidity ^0.5.10;

import './ValueProvider.sol';

contract DMap2 is ValueProvider {
    mapping(address=>bool)     public trusts; // Full owner-like
    mapping(bytes32=>bool)     public locked;
    mapping(bytes32=>bytes32)  public values;

    event ValueUpdate( bytes32 indexed key
                     , bytes32 indexed value );
    event ValueLocked( bytes32 indexed key
                     , bytes32 indexed value );
    event TrustUpdate( address indexed who
                     , bool    indexed trust );

    constructor() public {
        trusts[msg.sender] = true;
        emit TrustUpdate(msg.sender, true);
    }
    function getValue(bytes32 key) public view returns (bytes32) {
        return values[key];
    }
    function setValue(bytes32 key, bytes32 value) public {
        assert(trusts[msg.sender]);
        assert( ! locked[key] );
        values[key] = value;
        emit ValueUpdate(key, value);
    }
    function lock(bytes32 key) public {
        assert(trusts[msg.sender]);
        assert( ! locked[key]);
        locked[key] = true;
        emit ValueLocked(key, values[key]);
    }
    function trust(address who, bool t) public {
        assert(trusts[msg.sender]);
        trusts[who] = t;
        emit TrustUpdate(who, t);
    }
}

contract DMap2Factory {
    function build() public returns (DMap2) {
        return build(msg.sender);
    }
    function build(address owner) public returns (DMap2) {
        DMap2 dmap2 = new DMap2();
        dmap2.trust(owner, true);
        dmap2.trust(address(this), false);
        return dmap2;
    }
}
