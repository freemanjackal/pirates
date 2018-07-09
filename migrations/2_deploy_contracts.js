/*var ConvertLib = artifacts.require("./ConvertLib.sol");
var MetaCoin = artifacts.require("./MetaCoin.sol");

module.exports = function(deployer) {
  deployer.deploy(ConvertLib);
  deployer.link(ConvertLib, MetaCoin);
  deployer.deploy(MetaCoin);
};*/

var safemath = artifacts.require("./SafeMath.sol");
//var erc721 = artifacts.require("./ERC721.sol");
var ownable = artifacts.require("./Ownable.sol");
var pirateattack = artifacts.require("./PirateAttack.sol");
var piratefactory = artifacts.require("./PirateFactory.sol");
var piratefeeding = artifacts.require("./PirateFeeding.sol");
var piratehelper = artifacts.require("./PirateHelper.sol");
var pirateownership = artifacts.require("./PirateOwnership.sol");

module.exports = function(deployer) {
  deployer.deploy(safemath);
  //deployer.link(ConvertLib, MetaCoin);
  deployer.deploy(ownable);
  //deployer.deploy(erc721);
  
  deployer.deploy(piratefactory);
  deployer.deploy(piratefeeding);
  deployer.deploy(piratehelper);
  deployer.deploy(pirateattack);
  deployer.deploy(pirateownership);
  
};


