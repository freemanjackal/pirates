pragma solidity ^0.4.20;

import "./ownable.sol";
import "./safemath.sol";

contract PirateFactory is Ownable {

  using SafeMath for uint256;

  event NewPirate(uint pirateId, string name, uint dna);

  uint dnaDigits = 16;
  uint dnaModulus = 10 ** dnaDigits;
  uint cooldownTime = 1 days;

  struct Pirate {
    string name;
    uint dna;
    uint32 level;
    uint32 readyTime;
    uint16 winCount;
    uint16 lossCount;
  }

  Pirate[] public pirates;

  mapping (uint => address) public pirateToOwner;
  mapping (address => uint) ownerPirateCount;

  function _createPirate(string _name, uint _dna) internal {
    uint id = pirates.push(Pirate(_name, _dna, 1, uint32(now + cooldownTime), 0, 0)) - 1;
    pirateToOwner[id] = msg.sender;
    ownerPirateCount[msg.sender]++;
    emit NewPirate(id, _name, _dna);
  }

//delete view
  function _generateRandomDna(string _str) private view returns (uint) {
    uint rand = uint(keccak256(_str));
    return rand % dnaModulus;
  }

  function createRandomPirate(string _name) public {
    require(ownerPirateCount[msg.sender] == 0);
    uint randDna = _generateRandomDna(_name);
    randDna = randDna - randDna % 100;
    _createPirate(_name, randDna);
  }

  function getPiratesLenght() public view returns (uint) {
     return pirates.length;
 }

}

