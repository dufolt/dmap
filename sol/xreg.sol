// dmap .x.
// the worst registry
// do not use this one

pragma solidity ^0.5.10;

import "./dmap.sol";

contract xreg {
    DMap public x;
    constructor() public {
        x = new DMap();
    }
    function newChild(bytes32 name) public returns (DMap) {
        DMap map = new DMap();
        register(name, bytes32(bytes20(address( map ))));
        map.setOwner(msg.sender);
        return map;
    }
    function register(bytes32 key, bytes32 val) public {
        assert(x.getValue(key) == 0x0);
        x.setValue(key, val);
    }
}
