const hre = require("hardhat");
const fs = require("fs");

async function deployContract() {
  const CONTRACT_NAME = "LotionNFT";
  const [deployer] = await hre.ethers.getSigners();
  console.log("Deploying contract with the account:", deployer.address);

  const contractFactory = await hre.ethers.getContractFactory(CONTRACT_NAME);
  const contract = await contractFactory.deploy();
  await contract.deployed();
  console.log(`${CONTRACT_NAME} deployed to address: ${contract.address}`);

  // Replace with your own lotion name, description, and ingredients
  const name = "My Lotion";
  const description = "This is a description of my lotion";
  const ingredients = [
    { wallet: "0x1234567890123456789012345678901234567890", name: "Ingredient 1" },
    { wallet: "0x2345678901234567890123456789012345678901", name: "Ingredient 2" },
    { wallet: "0x3456789012345678901234567890123456789012", name: "Ingredient 3" },
  ];

  const tx = await contract.createLotion(name, description, ingredients);
  console.log(`Lotion NFT created successfully with transaction hash: ${tx.hash}`);
}

deployContract();