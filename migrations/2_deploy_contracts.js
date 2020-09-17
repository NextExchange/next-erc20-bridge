var NextToken = artifacts.require("NextToken");
var NextRegistry = artifacts.require("NextRegistry");

var ownerAccount = "0x1fce8974994B6F738c3aF17e2CE40e4393BE6b0E"; // The deployer account

module.exports = async function(deployer) {

    await deployer.deploy(NextToken);
    await deployer.deploy(NextRegistry);

    NextRegistryInstance = await NextRegistry.deployed();

    await NextRegistryInstance.addVersion(1,NextToken.address);
    await NextRegistryInstance.createProxy(1,
      ownerAccount // owner account for nextToken
      );

    tokenAddress = await NextRegistryInstance.proxyAddress();

    console.log("ProxyAddress :",tokenAddress);
};
