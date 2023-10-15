## Chain Configuration

The CoW Watch Tower package is configured to connect to the following networks by default:
- `mainnet`
- `gnosis`

If you wish to connect to other networks, you may do so by adding the following to the `EXTRA_OPTS` configuration option:

```
--chain-config <rpc>,<deploymentBlock>[,watchdogTimeout,orderBookApiUrl]
```

If you have installed a Staking configuration for a chain, the watch-tower will automatically connect to the staking node's execution client.

### Monitoring Dashboard

If you have installed [DMS](http://my.dappnode/#/installer/dms.dnp.dappnode.eth), a dashboard is automatically configured allowing you to monitor your `watch-tower` node's performance.

## Feedback and useful sites

If you have any questions about the Watch-Tower on DAppNode, you may find the package maintainer @mfw78 on both the [CoW Protocol Discord](https://discord.com/invite/cowprotocol) and [Dappnode Discord](https://discord.gg/N6q4MVQFGg). If you have any suggestions, bug fixes, PRs etc are welcome on the issue tracker as indicated below.

Sites that may be of interest:

* [`composable-cow`](https://github.com/cowprotocol/composable-cow)
