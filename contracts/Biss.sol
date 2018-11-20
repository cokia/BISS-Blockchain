pragma solidity ^0.4.23;

contract Biss {

    struct Firmware {
        string key;
        string hash;
    }

    mapping (address => string) dataStorage; // msg.sender => data string
    mapping (uint => Firmware) firmwares; // fileid => Firmware

    function saveData(string _message) public { // 디바이스에서 message를 일시적으로 저장
        dataStorage[msg.sender] = _message;
    }

    function loadData(address _sender) public view returns (string) { // 수신할 디바이스의 wallet
        return dataStorage[_sender];
    }

    function saveKey(uint _fileID, string _key) public { // fileID의 펌웨어에 key를 저장
        firmwares[_fileID].key = _key;
    }

    function saveHash(uint _fileID, string _hash) public { // fileID의 펌웨어에 hash(펌웨어 해시)를 저장
        firmwares[_fileID].hash = _hash;
    }

    function verifyHash(uint _fileID, string _hash) public view returns (bool) { // 해당 fileID의 해시가 _hash인지 확인
        return (keccak256(abi.encodePacked(firmwares[_fileID].hash)) == keccak256(abi.encodePacked(_hash)));
    }

}
