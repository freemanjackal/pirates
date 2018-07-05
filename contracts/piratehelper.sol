pragma solidity ^0.4.20;

import "./piratefeeding.sol";

contract PirateHelper is PirateFeeding {

  uint levelUpFee = 0.001 ether;

  modifier aboveLevel(uint _level, uint _pirateId) {
    require(pirates[_pirateId].level >= _level);
    _;
  }

  function withdraw() external onlyOwner {
    owner.transfer(address(this).balance);
  }

  function setLevelUpFee(uint _fee) external onlyOwner {
    levelUpFee = _fee;
  }

  function levelUp(uint _pirateId) external payable {
    require(msg.value == levelUpFee);
    pirates[_pirateId].level++;
  }

  function changeName(uint _pirateId, string _newName) external aboveLevel(2, _pirateId) onlyOwnerOf(_pirateId) {
    pirates[_pirateId].name = _newName;
  }

  function changeDna(uint _pirateId, uint _newDna) external aboveLevel(20, _pirateId) onlyOwnerOf(_pirateId) {
    pirates[_pirateId].dna = _newDna;
  }

//delete view
  function getPiratesByOwner(address _owner) external view returns(uint[]) {
    uint[] memory result = new uint[](ownerPirateCount[_owner]);
    uint counter = 0;
    for (uint i = 0; i < pirates.length; i++) {
      if (pirateToOwner[i] == _owner) {
        result[counter] = i;
        counter++;
      }
    }
    return result;
  }

}

