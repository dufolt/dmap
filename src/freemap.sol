// Free as in free-for-all
// Squatter-friendly

import 'src/DMap.sol';

contract FreemapFaucet {
    DMap public freemap;
    constructor(DMap freemap_) {
        freemap = freemap_
    } 
    function register(bytes32 key, bytes32 val)
        returns (bool success)
    {
        var existing = freemap.getValue(key);
        if (existing != 0x0) {
            freemap.setValue(val);
            return true;
        } else {
            return false;
        }
    }
}
