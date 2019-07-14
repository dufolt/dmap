// quickstart, and curious patterns

pragma solidity ^0.5.10;

import 'wrap.sol';

contract DMapQuickStart {
    function makeDMapAndWrap(address giveTo)
        public returns (DWrap)
    {
        DMap node = new DMap();
        DWrap wrap = new DWrap(node);
        node.setOwner(address(wrap));
        wrap.give(giveTo);
        return wrap;
    }
    function reWrap(DWrap oldWrap, address giveTo)
        public returns (DWrap)
    {
        oldWrap.give(address(this));
        DMap node = oldWrap.eject();
        DWrap newWrap = new DWrap(node);
        node.setOwner(address(newWrap));
        newWrap.give(giveTo);
        return newWrap;
    }
    function wrapExisting(DMap node, address giveTo)
        public returns (DWrap)
    {
        DWrap wrap = new DWrap(node);
        wrap.give(giveTo);
        return wrap;
        // Now you must `node.setOwner(wrap)`
    }
}
