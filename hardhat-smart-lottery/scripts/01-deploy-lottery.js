const { getNamedAccounts, network } = require("hardhat")

module.exports = async function ({getnamedAccounts, deployments}) {
    const {deploy, log} = deployments
    const {deployer} = await getNamedAccounts()

    const raffle = await deploy("lottery",{
        from: deployer,
        args: [],
        log:true,
        waitConfirmations: network.config.blockConfirmations || 1,

    })
}