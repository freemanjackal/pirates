pragma solidity ^0.4.20;

import "./piratefactory.sol";

contract PetInterface {
  //delete view
  function kidnap(uint256 _id) external view returns (
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 birthTime,
    uint256 generation,
    uint256 genes
  );
}

contract PirateFeeding is PirateFactory {

  PetInterface petContract;

  modifier onlyOwnerOf(uint _pirateId) {
    require(msg.sender == pirateToOwner[_pirateId]);
    _;
  }

  function setPetContractAddress(address _address) external onlyOwner {
    petContract = PetInterface(_address);
  }

  function _triggerCooldown(Pirate storage _pirate) internal {
    _pirate.readyTime = uint32(now + cooldownTime);
  }

  function _isReady(Pirate storage _pirate) internal view returns (bool) {
      return (_pirate.readyTime <= now);
  }
//it would be great to set a function to kidnap pirate's pets---kidnap kitties would be a great stealPirate
//obviuosly without any real effect so it could be designed another fungible tokens to be pirates pets
//that could be kidnaped and ask a ransom for them
//it could then  been designed a token for the game to steal from pirates and to pay ransoms
  function stealPirate(uint _pirateId, uint _pirateIdEnemy, string typeAttack) internal onlyOwnerOf(_pirateId) {
    Pirate storage myPirate = pirates[_pirateId];
    require(_isReady(myPirate));
    
    
    /*if (keccak256(_species) == keccak256("attack")) {
      
    }*/
    _triggerCooldown(myPirate);
  }

  function _kiddnapPet(uint _pirateId, uint _kittyId) internal {
    uint petDna;
    (,,,,,petDna) = petContract.kidnap(_kittyId);
  }
}

