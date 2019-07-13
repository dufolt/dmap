pragma solidity ^0.5.10;

contract DMap {
    address                    public getOwner;
    mapping(bytes32=>bytes32)  public getValue;

    event ValueUpdate( bytes32 indexed key
                     , bytes32 indexed value );
    event OwnerUpdate( address indexed oldOwner
                     , address indexed newOwner );

    constructor() public {
        getOwner = msg.sender;
        emit OwnerUpdate(address(0), getOwner);
    }

    function setValue(bytes32 key, bytes32 value) public {
        assert(msg.sender == getOwner);
        getValue[key] = value;
        emit ValueUpdate(key, value);
    }
    function setOwner(address newOwner) public {
        assert(msg.sender == getOwner);
        getOwner = newOwner;
        emit OwnerUpdate(msg.sender, getOwner);
    }
}
