// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";



contract DynamicGokuNFT is ERC721, ERC721URIStorage, Ownable  {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    struct TokenDetails{
        uint id;
        uint level;
        uint lastUpgradeTime;
    }

    TokenDetails public tokenDetails;

    mapping(uint => TokenDetails) public tokenRegistry;
    
    string[] level0 = [
        "https://gateway.pinata.cloud/ipfs/QmNRPMoUtRjv2gqShWBGbPWnm2EfNSBCZYTK8Q5Ro3rKNV/level0%20%281%29.json",
        "https://gateway.pinata.cloud/ipfs/QmNRPMoUtRjv2gqShWBGbPWnm2EfNSBCZYTK8Q5Ro3rKNV/level0%20%282%29.json",
        "https://gateway.pinata.cloud/ipfs/QmNRPMoUtRjv2gqShWBGbPWnm2EfNSBCZYTK8Q5Ro3rKNV/level0%20%283%29.json"
    ];

    string[] level1 = [
    "https://gateway.pinata.cloud/ipfs/QmNRPMoUtRjv2gqShWBGbPWnm2EfNSBCZYTK8Q5Ro3rKNV/level1%20%281%29.json",
    "https://gateway.pinata.cloud/ipfs/QmNRPMoUtRjv2gqShWBGbPWnm2EfNSBCZYTK8Q5Ro3rKNV/level1%20%282%29.json",
    "https://gateway.pinata.cloud/ipfs/QmNRPMoUtRjv2gqShWBGbPWnm2EfNSBCZYTK8Q5Ro3rKNV/level1%20%283%29.json"
    ];

    string[] level2 = [
    "https://gateway.pinata.cloud/ipfs/QmNRPMoUtRjv2gqShWBGbPWnm2EfNSBCZYTK8Q5Ro3rKNV/level2%20%281%29.json",
    "https://gateway.pinata.cloud/ipfs/QmNRPMoUtRjv2gqShWBGbPWnm2EfNSBCZYTK8Q5Ro3rKNV/level2%20%282%29.json",
    "https://gateway.pinata.cloud/ipfs/QmNRPMoUtRjv2gqShWBGbPWnm2EfNSBCZYTK8Q5Ro3rKNV/level2%20%283%29.json"   
    ];

    string[] level3 = [
    "https://gateway.pinata.cloud/ipfs/QmNRPMoUtRjv2gqShWBGbPWnm2EfNSBCZYTK8Q5Ro3rKNV/level3%20%281%29.json",
    "https://gateway.pinata.cloud/ipfs/QmNRPMoUtRjv2gqShWBGbPWnm2EfNSBCZYTK8Q5Ro3rKNV/level3%20%282%29.json",
    "https://gateway.pinata.cloud/ipfs/QmNRPMoUtRjv2gqShWBGbPWnm2EfNSBCZYTK8Q5Ro3rKNV/level3%20%283%29.json"    
    ];

    string[] level4 = [
     "https://gateway.pinata.cloud/ipfs/QmNRPMoUtRjv2gqShWBGbPWnm2EfNSBCZYTK8Q5Ro3rKNV/level4%20%281%29.json",
     "https://gateway.pinata.cloud/ipfs/QmNRPMoUtRjv2gqShWBGbPWnm2EfNSBCZYTK8Q5Ro3rKNV/level4%20%282%29.json",
     "https://gateway.pinata.cloud/ipfs/QmNRPMoUtRjv2gqShWBGbPWnm2EfNSBCZYTK8Q5Ro3rKNV/level4%20%283%29.json"  
    ];

    string[] level5 = [
    "https://gateway.pinata.cloud/ipfs/QmNRPMoUtRjv2gqShWBGbPWnm2EfNSBCZYTK8Q5Ro3rKNV/level5%20%281%29.json",
    "https://gateway.pinata.cloud/ipfs/QmNRPMoUtRjv2gqShWBGbPWnm2EfNSBCZYTK8Q5Ro3rKNV/level5%20%282%29.json",
    "https://gateway.pinata.cloud/ipfs/QmNRPMoUtRjv2gqShWBGbPWnm2EfNSBCZYTK8Q5Ro3rKNV/level5%20%283%29.json"
    ];    

    string[] level6 = [
    "https://gateway.pinata.cloud/ipfs/QmNRPMoUtRjv2gqShWBGbPWnm2EfNSBCZYTK8Q5Ro3rKNV/level6%20%281%29.json",
    "https://gateway.pinata.cloud/ipfs/QmNRPMoUtRjv2gqShWBGbPWnm2EfNSBCZYTK8Q5Ro3rKNV/level6%20%282%29.json",
    "https://gateway.pinata.cloud/ipfs/QmNRPMoUtRjv2gqShWBGbPWnm2EfNSBCZYTK8Q5Ro3rKNV/level6%20%283%29.json"
    ];

    string GODLevel = "https://gateway.pinata.cloud/ipfs/QmNRPMoUtRjv2gqShWBGbPWnm2EfNSBCZYTK8Q5Ro3rKNV/GokuGODLevel7.json";

    constructor() ERC721("DynamicGameNFT", "GOKU") {
    }

    function random() public view returns(uint){
        return uint(keccak256(abi.encodePacked(block.timestamp,block.difficulty, 
        msg.sender))) % 3;
    }

    function safeMint(address to) public  {
        // Current counter value will be the minted token's token ID.
        uint256 tokenId = _tokenIdCounter.current();

        // Increment it so next time it's correct when we call .current()
        _tokenIdCounter.increment();

        tokenRegistry[tokenId].id = tokenId;
        tokenRegistry[tokenId].level = 0;
        tokenRegistry[tokenId].lastUpgradeTime = block.timestamp;

        uint randomNum = random();

        // Mint the token
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, level0[randomNum]);

    }

    function upgradeNFT(uint _tokenId) public {
        require(msg.sender == ownerOf(_tokenId), "Not owner");
        require(block.timestamp > tokenRegistry[_tokenId].lastUpgradeTime + 10,"Cooling time, Can't upgrade now");
        require(tokenRegistry[_tokenId].level <= 6, "Highest level reached, no upgrades available !!");

        uint currentLevel = tokenRegistry[_tokenId].level;
        uint nextLevel = currentLevel+1 ;
        tokenRegistry[_tokenId].level = nextLevel;

        tokenRegistry[_tokenId].lastUpgradeTime = block.timestamp;

        uint randomNum = random();
        
        if(nextLevel == 1){
            _setTokenURI(_tokenId, level1[randomNum]);
        }

        if(nextLevel == 2){
            _setTokenURI(_tokenId, level2[randomNum]);
        }

        if(nextLevel == 3){
            _setTokenURI(_tokenId, level3[randomNum]);
        }

        if(nextLevel == 4){
            _setTokenURI(_tokenId, level4[randomNum]);
        }

        if(nextLevel == 5){
            _setTokenURI(_tokenId, level5[randomNum]);
        }

        if(nextLevel == 6){
            _setTokenURI(_tokenId, level6[randomNum]);
        }

        if(nextLevel == 7){
            _setTokenURI(_tokenId, GODLevel);
        }


    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function checkLevel(uint _tokenId) public view returns(uint){
        uint currentLevel = tokenRegistry[_tokenId].level;
        return currentLevel;
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721/*, ERC721Enumerable*/)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
