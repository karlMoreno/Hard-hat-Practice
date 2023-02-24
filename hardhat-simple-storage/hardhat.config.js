require("@nomicfoundation/hardhat-toolbox")
require("@nomiclabs/hardhat-etherscan")
require("./tasks/block-number")
require("hardhat-gas-reporter")

/** @type import('hardhat/config').HardhatUserConfig */
const ETHERSCAN_API_KEY = process.env.ETHERSCAN_API_KEY
const COINMARKETCAP_API_KEY = process.env.COINMARKETCAP_API_KEY
module.exports = {
    defaultNetwork: "hardhat",
    networks: {
      localhost: {
        url: "http://127.0.0.1:8545/",
      // accounts already has
      chainId: 31337,
      }
    },
    solidity: "0.8.17",
    etherscan: {
        apiKey: ETHERSCAN_API_KEY,
    },
    gasReporter: {
      enabled:true,
      outputFile: "gas-report.txt",
      noColorts: true,
      currency: "USD",
      coinmarketcap: COINMARKETCAP_API_KEY,
      token: "MATIC",
    },
}
