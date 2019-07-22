// A factory that logs DMap and DWrap creation events
// All DMaps are valid, even if they are not constructed here

pragma solidity ^0.5.10;

import './wrap.sol';

contract QuickStart {

    event NewDMap(DMap indexed node);
    event NewDWrap(DWrap indexed wrap);

    function makeDMap() public returns (DMap) {
        DMap node = new DMap();

        emit NewDMap(node);

        node.setOwner(msg.sender);
        return node;
    }

    function makeDWrap() public returns (DWrap)
    {
        DMap node = new DMap();
        DWrap wrap = new DWrap(node);

        emit NewDMap(node);
        emit NewDWrap(wrap);

        node.setOwner(address(wrap));
        wrap.setOwner(msg.sender);
        return wrap;
    }

    function makeDWrap(DMap node) public returns (DWrap) {
        DWrap wrap = new DWrap(node);

        emit NewDWrap(wrap);
    
        wrap.setOwner(msg.sender);
        return wrap;
    
        // Now caller should call `node.setOwner(wrap)`
        // IE
        //    var node = ...
        //    var wrap = makeDWrap(node);
        //    node.setOwner(wrap);
    }


}
