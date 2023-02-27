const hre = require("hardhat");

async function main() {
  // Compile the contract
  await hre.run('compile');

  // Deploy the contract
  const TokenGenerator = await hre.ethers.getContractFactory("TokenGenerator");
  const generator = await TokenGenerator.deploy();

  // Wait for the contract to be deployed
  await generator.deployed();

  console.log("TokenGenerator deployed to:", generator.address);

  // Generate tokens and send them to four wallet addresses
  const accounts = [
    process.env.LOREAL_WALLET,
    process.env.WAK_WALLET, 
    process.env.DUC_LOI_WALLET,
    process.env.SCARLET_WALLET];
  const receivers = [
    accounts[0],
    accounts[1],
    accounts[2],
    accounts[3]
  ];
  await generator.generateTokens(receivers);

  console.log("Tokens generated and sent to:", receivers);
}

// Run the main function
main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });