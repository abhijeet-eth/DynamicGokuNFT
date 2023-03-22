const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Greeter", async function () {

  // before("deploy contracts", async () => {

  // }) 

  it("owner should mint Dynamic nft", async function () {

    const Dynamic = await hre.ethers.getContractFactory("DynamicGokuNFT");
    const dynamic = await Dynamic.deploy();
    
    await dynamic.deployed();
  
    console.log(
      `Dynamic Goku NFT contract deployed to ${dynamic.address}`
    );

    accounts = await ethers.getSigners()
    
    // for(i=1 ; i<1000;i++){
    //   await dynamic.safeMint(accounts[1].address);
    //   console.log("i ==", i)
    // }
    // console.log("Balll == ",await dynamic.balanceOf(accounts[1].address))
    await dynamic.safeMint(accounts[1].address);

    await hre.ethers.provider.send('evm_increaseTime', [12]);

    await dynamic.connect(accounts[1]).upgradeNFT(0)

  });
});