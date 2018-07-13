/*var MetaCoin = artifacts.require("./MetaCoin.sol");

contract('MetaCoin', function(accounts) {
  it("should put 10000 MetaCoin in the first account", function() {
    return MetaCoin.deployed().then(function(instance) {
      return instance.getBalance.call(accounts[0]);
    }).then(function(balance) {
      assert.equal(balance.valueOf(), 10000, "10000 wasn't in the first account");
    });
  });
  it("should call a function that depends on a linked library", function() {
    var meta;
    var metaCoinBalance;
    var metaCoinEthBalance;

    return MetaCoin.deployed().then(function(instance) {
      meta = instance;
      return meta.getBalance.call(accounts[0]);
    }).then(function(outCoinBalance) {
      metaCoinBalance = outCoinBalance.toNumber();
      return meta.getBalanceInEth.call(accounts[0]);
    }).then(function(outCoinBalanceEth) {
      metaCoinEthBalance = outCoinBalanceEth.toNumber();
    }).then(function() {
      assert.equal(metaCoinEthBalance, 2 * metaCoinBalance, "Library function returned unexpected function, linkage may be broken");
    });
  });
  it("should send coin correctly", function() {
    var meta;

    // Get initial balances of first and second account.
    var account_one = accounts[0];
    var account_two = accounts[1];

    var account_one_starting_balance;
    var account_two_starting_balance;
    var account_one_ending_balance;
    var account_two_ending_balance;

    var amount = 10;

    return MetaCoin.deployed().then(function(instance) {
      meta = instance;
      return meta.getBalance.call(account_one);
    }).then(function(balance) {
      account_one_starting_balance = balance.toNumber();
      return meta.getBalance.call(account_two);
    }).then(function(balance) {
      account_two_starting_balance = balance.toNumber();
      return meta.sendCoin(account_two, amount, {from: account_one});
    }).then(function() {
      return meta.getBalance.call(account_one);
    }).then(function(balance) {
      account_one_ending_balance = balance.toNumber();
      return meta.getBalance.call(account_two);
    }).then(function(balance) {
      account_two_ending_balance = balance.toNumber();

      assert.equal(account_one_ending_balance, account_one_starting_balance - amount, "Amount wasn't correctly taken from the sender");
      assert.equal(account_two_ending_balance, account_two_starting_balance + amount, "Amount wasn't correctly sent to the receiver");
    });
  });
});
*/

var ownership = artifacts.require("./PirateOwnership.sol");

contract('ownership', function(accounts) {
  it("should put 10000 MetaCoin in the first account", function() {
    return ownership.deployed().then(function(instance) {
      //return instance.getPiratesByOwner.call(accounts[0]);
      return instance.createRandomPirate("lolo");
    }).then(function(value) {
      console.log(value);
    });
  });
  it("test creation", function() {
    return ownership.deployed().then(function(instance) {
      return instance.getPiratesByOwner.call(accounts[0]);
      
    }).then(function(value) {
      console.log(value);
    });
  });
  it("test attack", async function() {
    /*return ownership.deployed().then(function(instance) {
      await instance.createRandomPirate("loloss", {from: accounts[1]});
      await instance.createRandomPirate("pepe", {from: accounts[2]});
      let len = await instance.getPiratesLenght.call();
      console.log(len);
      //return instance.attack(0,1, {from: accounts[1]});
      
    }).then(function(value) {
      console.log(value);
    });*/
    //const RefundablePresale = artifacts.require('RefundablePresale.sol')
    //const MyPlubitToken = artifacts.require('MyPlubitToken.sol')
    this.token  = await ownership.new();
    await this.token.createRandomPirate("loloss", {from: accounts[1]});
    await this.token.createRandomPirate("pepe", {from: accounts[2]});
    let len = await this.token.getPiratesLenght.call();
    console.log(JSON.parse(len));
    console.log("aaaaaaaaaaaaaaaa");
    await this.token.attack(1,0, {from: accounts[2]});
    assert.equal(2, len);
  });

})