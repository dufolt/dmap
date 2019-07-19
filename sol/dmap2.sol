pragma solidity ^0.5.10;

import 'interface/ValueProvider.sol';

contract DMap2 is ValueProvider {
    address                    public owner;
    mapping(address=>bool)     public trusts;
    mapping(bytes32=>bytes32)  public values;


    event ValueUpdate( bytes32 indexed key
                     , bytes32 indexed value );
    event OwnerUpdate( address indexed oldOwner
                     , address indexed newOwner );

    constructor() public {
        owner = msg.sender;
        emit OwnerUpdate(address(0), owner);
    }
    function getValue(bytes32 key) public view returns (bytes32) {
        return values[key];
    }
    function getOwner() public view returns (address) {
        return owner;
    }

    function auth() internal {
        assert(msg.sender == owner || trusts[msg.sender]);
    }
    function trust(address who, bool t) {
        auth();
        trusts[who] = t;
    }
    function setValue(bytes32 key, bytes32 value) public {
        auth();
        values[key] = value;
        emit ValueUpdate(key, value);
    }
    function setOwner(address newOwner) public {
        auth();
        owner = newOwner;
        emit OwnerUpdate(msg.sender, owner);
    }

}
