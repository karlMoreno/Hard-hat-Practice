const { ethers } = require("hardhat");

async function main() {
  const LotionNFT = await ethers.getContractFactory("LotionNFT");
  const lotionNFT = await LotionNFT.deploy();

  console.log("LotionNFT deployed to:", lotionNFT.address);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
