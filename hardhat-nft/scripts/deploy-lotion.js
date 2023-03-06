const { ethers } = require("hardhat");

async function main() {
  const LotionNFT = await ethers.getContractFactory("LotionNFT");
  const lotionNFT = await LotionNFT.deploy();

  await lotionNFT.deployed();

  console.log("LotionNFT contract deployed to:", lotionNFT.address);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
