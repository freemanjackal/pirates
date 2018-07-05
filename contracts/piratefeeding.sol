pragma solidity ^0.4.19;

import "./piratefactory.sol";

contract KittyInterface {
  function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
  );
}

contract PirateFeeding is PirateFactory {

  KittyInterface kittyContract;

  modifier onlyOwnerOf(uint _pirateId) {
    require(msg.sender == pirateToOwner[_pirateId]);
    _;
  }

  function setKittyContractAddress(address _address) external onlyOwner {
    kittyContract = KittyInterface(_address);
  }

  function _triggerCooldown(Pirate storage _pirate) internal {
    _pirate.readyTime = uint32(now + cooldownTime);
  }

  function _isReady(Pirate storage _pirate) internal view returns (bool) {
      return (_pirate.readyTime <= now);
  }

  function feedAndMultiply(uint _pirateId, uint _targetDna, string _species) internal onlyOwnerOf(_pirateId) {
    Pirate storage myPirate = pirates[_pirateId];
    require(_isReady(myPirate));
    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myPirate.dna + _targetDna) / 2;
    if (keccak256(_species) == keccak256("kitty")) {
      newDna = newDna - newDna % 100 + 99;
    }
    _createPirate("NoName", newDna);
    _triggerCooldown(myPirate);
  }

  function feedOnKitty(uint _pirateId, uint _kittyId) public {
    uint kittyDna;
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
    feedAndMultiply(_pirateId, kittyDna, "kitty");
  }
}

