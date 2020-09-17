/* NEXT.EXCHANGE SMART CONTRACT CONFIG */

var HDWalletProvider = require("truffle-hdwallet-provider");
const MNEMONIC = '';

const Web3 = require("web3");
const web3 = new Web3();

module.exports = {

  //plugins: ["truffle-security"],

  compilers: {
    solc: {
      version: "^0.6.0",
      settings: {
        optimizer: {
          enabled: true,
          runs: 200
        }
      }
    }
 },
  networks: {
    development: {
      host: "127.0.0.1",
      port: 9545,
      network_id: "*"
    },
    mainnet: {
      provider: function() {
        return new HDWalletProvider(MNEMONIC,"https://mainnet.infura.io/v3/")
      },
      network_id: '1',
      gas: 8000000,
      gasPrice: 41000000000,
      timeoutBlocks: 200,
      skipDryRun: true
    },
    ropsten: {
      provider: function() {
        return new HDWalletProvider(MNEMONIC,"https://ropsten.infura.io/v3/")
      },
      network_id: '3',
      gas: 8000000,
	    gasPrice: web3.utils.toWei('41', 'gwei'), // 41 GWEI
	    timeoutBlocks: 200,
	    skipDryRun: true
    },
  }
};
