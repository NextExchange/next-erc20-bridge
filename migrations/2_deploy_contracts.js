var NextToken = artifacts.require("NextToken");
var NextRegistery = artifacts.require("NextRegistery");

var ownerAccount = "0x4c185CDAA130bE6f8dad25737F9073eB497E6660"; // The deployer account

module.exports = async function(deployer) {

    await deployer.deploy(NextToken);
    await deployer.deploy(NextRegistery);

    NextRegisteryInstance = await NextRegistery.deployed();

    await NextRegisteryInstance.addVersion(1,NextToken.address);
    await NextRegisteryInstance.createProxy(1,
      ownerAccount // owner account for nextToken
      );

    tokenAddress = await NextRegisteryInstance.proxyAddress();

    console.log("ProxyAddress :",tokenAddress);
};
