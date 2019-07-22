pragma solidity ^0.5.10;

contract ValueProvider {
    function getValue(bytes32 key) public view returns (bytes32 value);
    event ValueUpdate(bytes32 indexed key, bytes32 indexed value);
}
