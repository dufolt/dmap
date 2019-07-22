pragma solidity ^0.5.10;

import './ValueProvider.sol';

contract DMap is ValueProvider {
    address                    private _owner;
    mapping(bytes32=>bytes32)  private _values;

    event ValueUpdate( bytes32 indexed key
                     , bytes32 indexed value );
    event OwnerUpdate( address indexed oldOwner
                     , address indexed newOwner );

    constructor() public {
        _owner = msg.sender;
        emit OwnerUpdate(address(0), _owner);
    }

    function getValue(bytes32 key) public view returns (bytes32) {
        return _values[key];
    }
    function setValue(bytes32 key, bytes32 value) public {
        assert(msg.sender == _owner);
        _values[key] = value;
        emit ValueUpdate(key, value);
    }
    function getOwner() public view returns (address) {
        return _owner;
    }
    function setOwner(address newOwner) public {
        assert(msg.sender == _owner);
        _owner = newOwner;
        emit OwnerUpdate(msg.sender, _owner);
    }
}
