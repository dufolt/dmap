// single-use control wrapper for individual `DMap`s
// The reference to the wrapped node is preserved even
// if it is `eject`ed. Calls to `getValue(bytes32)` will
// will continue to resolve to underlying node.

pragma solidity ^0.5.10;

import './dmap.sol';

contract DWrap {
    DMap                   public node;
    address                public owner;
    mapping(address=>bool) public trusts;

    event OwnerUpdate( address indexed oldOwner
                     , address indexed newOwner );
    event TrustUpdate( address indexed caller
                     , bool    indexed trust );

    constructor(DMap dmap) public {
        owner = msg.sender;
        node = dmap;
        emit OwnerUpdate(address(0), address(this));
    }
    function auth(address caller) internal view {
        assert(caller == owner || trusts[caller]);
    }
    function trust(address a, bool b) public {
        auth(msg.sender);
        trusts[a] = b;
    }
    function getValue(bytes32 key) public view returns (bytes32) {
        return node.getValue(key);
    }
    function setValue(bytes32 key, bytes32 value) public {
        auth(msg.sender);
        node.setValue(key, value);
    }
    function getOwner() public view returns (address) {
        return owner;
    }
    function setOwner(address newOwner) public {
        auth(msg.sender);
        emit OwnerUpdate(owner, newOwner);
        owner = newOwner;
    }
    function eject() public returns (DMap) {
        auth(msg.sender);
        owner = address(0);
        node.setOwner(msg.sender);
        return node;
    }
}
