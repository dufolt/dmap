// control wrapper for individual `DMap`s

pragma solidity ^0.5.10;

import 'dmap.sol';

contract DWrap {
    DMap                   public node;
    address                public owner;
    mapping(address=>bool) public trusts;

    event OwnerUpdate( address indexed oldOwner
                     , address indexed newOwner );
    event TrustUpdate( address indexed caller
                     , bool    indexed trust );

    constructor(DMap node_) public {
        node = node_;
        owner = msg.sender;
        emit OwnerUpdate(address(0), address(this));
    }
    function authorize(address caller) internal view {
        assert(caller == owner || trusts[caller]);
    }
    function write(bytes32 key, bytes32 value) public {
        authorize(msg.sender);
        node.setValue(key, value);
    }
    function give(address to) public {
        authorize(msg.sender);
        emit OwnerUpdate(owner, to);
        owner = to;
    }
    function trust(address a, bool b) public {
        authorize(msg.sender);
        trusts[a] = b;
    }
    function eject() public returns (DMap) {
        DMap ret = node;
        authorize(msg.sender);
        node.setOwner(msg.sender);
        // Decommission this DWrap
            emit OwnerUpdate(address(this), address(0));
            node = DMap(address(0));
            owner = address(0);
        // whew
        return ret;
    }
}
