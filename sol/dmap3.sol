pragma solidity ^0.5.10;

import './ValueProvider.sol';

contract DMap3 is ValueProvider {
    address                   public allocator;
    mapping(bytes32=>bool)    public locked;
    mapping(bytes32=>bytes32) public values;
    mapping(bytes32=>address) public owners;
    mapping(bytes32=>address) public offered;

    event ValueUpdate( bytes32 indexed key
                     , bytes32 indexed value );
    event ValueLocked( bytes32 indexed key
                     , bytes32 indexed value );
    event OwnerUpdate( bytes32 indexed key
                     , address indexed oldOwner
                     , address indexed newOwner );

    constructor() public {
        allocator = msg.sender;
    }
    function setAllocator(address newAllocator) public {
        assert(msg.sender == allocator);
        allocator = newAllocator;
    }
    function allocate(bytes32 key, address owner) public {
        assert( ! locked[key]);
        assert(msg.sender == allocator);
        assert(owner != address(0));
        assert(owners[key] != address(0));
        owners[key] = owner;
        emit OwnerUpdate(key, address(this), owner);
    }
    function lock(bytes32 key) public {
        assert( ! locked[key]); // one lock event
        assert(msg.sender == owners[key]);
        locked[key] = true;
        owners[key] = address(0);
        offered[key] = address(0);
        emit ValueLocked(key, values[key]);
    }
    function offer(bytes32 key, address to) public {
        assert( ! locked[key]);
        assert(msg.sender == owners[key]);
        offered[key] = to;
    }
    function accept(bytes32 key) public {
        assert( ! locked[key]);
        assert(msg.sender == offered[key]);
        emit OwnerUpdate(key, owners[key], offered[key]);
        owners[key] = msg.sender;
        offered[key] = address(0);
    }
    function setValue(bytes32 key, bytes32 value) public {
        assert( ! locked[key]);
        assert(msg.sender == owners[key]);
        values[key] = value;
        emit ValueUpdate(key, value);
    }
    function getValue(bytes32 key) public view returns (bytes32) { 
        return values[key];
    }
}

contract DMap3Factory {
    function build() public returns (DMap3) {
        return build(msg.sender);
    }
    function build(address allocator) public returns (DMap3) {
        DMap3 dmap3 = new DMap3();
        dmap3.setAllocator(allocator);
        return dmap3;
    }
}
