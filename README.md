# NEXT smart  bridge token contract

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

The smart contract of NEXT.exchange

What does it do (besides of be an ERC20 compatible token):

1]	Burn
2]  Mint
3]  Staking

## Tokenomics

Since it’s an ERC20 bridge, the max supply will be identical to the supply figures on NEXT.chain, which is 30.3M

### Installation

For testnet environments...
Use --reset, if the contract is already deployed

```sh
$ truffle compile
$ truffle migrate --network ropsten
```
sud
For production environments...

```sh
$ truffle deploy
```

### Audit
Developers can do their audit on https://tool.smartdec.net or https://securify.chainsecurity.com
Code which get published to mainnet needs to pass the Solium code quality and Security linter. See https://github.com/duaraghav8/Ethlint
