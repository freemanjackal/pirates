pragma solidity ^0.4.20;

import "./pirateattack.sol";
import "./erc721.sol";
import "./safemath.sol";

contract PirateOwnership is PirateAttack, ERC721 {

  using SafeMath for uint256;

  mapping (uint => address) pirateApprovals;
//delete view
  function balanceOf(address _owner) public view returns (uint256 _balance) {
    return ownerPirateCount[_owner];
  }
//delete view
  function ownerOf(uint256 _tokenId) public view returns (address _owner) {
    return pirateToOwner[_tokenId];
  }

  function _transfer(address _from, address _to, uint256 _tokenId) private {
    ownerPirateCount[_to] = ownerPirateCount[_to].add(1);
    ownerPirateCount[msg.sender] = ownerPirateCount[msg.sender].sub(1);
    pirateToOwner[_tokenId] = _to;
    emit Transfer(_from, _to, _tokenId);
  }

  function transfer(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
    _transfer(msg.sender, _to, _tokenId);
  }

  function approve(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
    pirateApprovals[_tokenId] = _to;
    emit Approval(msg.sender, _to, _tokenId);
  }

  function takeOwnership(uint256 _tokenId) public {
    require(pirateApprovals[_tokenId] == msg.sender);
    address owner = ownerOf(_tokenId);
    _transfer(owner, msg.sender, _tokenId);
  }
}

