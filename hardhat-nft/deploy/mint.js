const { network, ethers } = require("hardhat")

module.exports = async ({ getNamedAccounts }) => {
    const { deployer } = await getNamedAccounts()
    const chainId = network.config.chainId

    // Basic NFT
    const basicNFT = await ethers.getContract("basicNFT", deployer)
    const basicMintTx = await basicNFT.mintNft()
    await basicMintTx.wait(1)
    console.log(`Basic NFT index 0 tokenURI: ${await basicNFT.tokenURI(0)}`)


}
module.exports.tags = ["all", "mint"]