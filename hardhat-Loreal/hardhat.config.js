require("@nomicfoundation/hardhat-toolbox");


const COINMARKETCAP_API_KEY = process.env.COINMARKETCAP_API_KEY || ""
 const GOERLI_RPC_URL =
     process.env.GOERLI_RPC_URL || "https://eth-goerli.alchemyapi.io/v2/your-api-key"
 const PRIVATE_KEY = process.env.PRIVATE_KEY || "c994f392aa40981ca052719d8875ce03c567842018a28a1d9cff026018952042"
 const ETHERSCAN_API_KEY = process.env.ETHERSCAN_API_KEY || "W5IJH7JKXT12R39GAAE334VWN58BR6HRSR"
 


/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  networks: {
    hardhat: {
      chainId: 31337,
      gasPrice: 130000000000,
    },
    goerli: {
      url: GOERLI_RPC_URL,
      accounts: [PRIVATE_KEY],
      chainId: 5,
      blockConfirmations: 6,
    },
  },
  etherscan: {
    apiKey: ETHERSCAN_API_KEY,
},
};
