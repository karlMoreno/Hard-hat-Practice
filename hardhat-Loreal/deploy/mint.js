const { ethers } = require("hardhat");

async function main() {
  const LotionNFT = await ethers.getContractFactory("LotionNFT");
  const lotionNFT = await LotionNFT.attach("<contract_address>");

  const wallet1 = "<wallet_address_1>";
  const ingredient1FromWallet1 = "<ingredient_1_from_wallet_1>";
  const ingredient2FromWallet1 = "<ingredient_2_from_wallet_1>";

  const wallet2 = "<wallet_address_2>";
  const ingredient1FromWallet2 = "<ingredient_1_from_wallet_2>";
  const ingredient2FromWallet2 = "<ingredient_2_from_wallet_2>";

  const wallet3 = "<wallet_address_3>";
  const ingredient1FromWallet3 = "<ingredient_1_from_wallet_3>";
  const ingredient2FromWallet3 = "<ingredient_2_from_wallet_3>";

  const tx = await lotionNFT.createLotion(
    wallet1,
    ingredient1FromWallet1,
    ingredient2FromWallet1,
    wallet2,
    ingredient1FromWallet2,
    ingredient2FromWallet2,
    wallet3,
    ingredient1FromWallet3,
    ingredient2FromWallet3
  );

  console.log("LotionNFT minted with transaction:", tx.hash);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
