pragma solidity ^0.5.10;

import './interface/ValueProvider.sol';

contract DMap2 is ValueProvider {
    address                    public owner;
    mapping(address=>bool)     public trusts;
    mapping(bytes32=>bool)     public locked;
    mapping(bytes32=>bytes32)  public values;

    event OwnerUpdate( address indexed oldOwner
                     , address indexed newOwner );
    event ValueUpdate( bytes32 indexed key
                     , bytes32 indexed value );
    event ValueLocked( bytes32 indexed key
                     , bytes32 indexed value );

    constructor() public {
        owner = msg.sender;
        emit OwnerUpdate(address(0), owner);
    }
    function auth() internal {
        assert(msg.sender == owner || trusts[msg.sender]);
    }
    function getValue(bytes32 key) public view returns (bytes32) {
        return values[key];
    }
    function getOwner() public view returns (address) {
        return owner;
    }
    function trust(address who, bool t) public {
        auth();
        trusts[who] = t;
    }
    function lock(bytes32 key, bytes32 value) public {
        auth();
        assert( ! locked[key]);
        values[key] = value;
        locked[key] = true;
        emit ValueUpdate(key, value);
        emit ValueLocked(key, value); // yes 2 events
    }
    function lock(bytes32 key) public {
        lock(key, values[key]);
    }
    function setValue(bytes32 key, bytes32 value) public {
        auth();
        assert( ! locked[key] );
        values[key] = value;
        emit ValueUpdate(key, value);
    }
    function setOwner(address newOwner) public {
        auth();
        owner = newOwner;
        emit OwnerUpdate(msg.sender, owner);
    }
}
