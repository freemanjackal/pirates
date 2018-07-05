pragma solidity ^0.4.20;

import "./piratehelper.sol";

//contract PirateAttack is PirateHelper {
contract PirateAttack is PirateHelper {
  uint randNonce = 0;
  uint attackVictoryProbability = 70;

  function randMod(uint _modulus) internal returns(uint) {
    randNonce++;
    return uint(keccak256(now, msg.sender, randNonce)) % _modulus;
  }

  function attack(uint _pirateId, uint _targetId) external onlyOwnerOf(_pirateId) {
    Pirate storage myPirate = pirates[_pirateId];
    Pirate storage enemyPirate = pirates[_targetId];
    uint rand = randMod(100);
    if (rand <= attackVictoryProbability) {
      myPirate.winCount++;
      myPirate.level++;
      enemyPirate.lossCount++;
      feedAndMultiply(_pirateId, enemyPirate.dna, "pirate attack");
    } else {
      myPirate.lossCount++;
      enemyPirate.winCount++;
      _triggerCooldown(myPirate);
    }
  }
}

