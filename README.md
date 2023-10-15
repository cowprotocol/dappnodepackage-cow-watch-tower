# DAppNodePackage-cow-watch-tower

## **watch-tower**
![avatar](cow-avatar-min.png)

### What is cow-watch-tower?

`cow-watch-tower` is a package for DAppNode that monitors a block chain for conditional orders and posts them to the CoW Protocol's order book when they are ready to be executed.

### How does it work?

`cow-watch-tower` is a node.js application that connects to a block chain node and monitors the block chain for conditional orders. When it finds a conditional order, it posts it to the CoW Protocol's order book. It is capable of monitoring multiple block chains at once.

If the watch-tower detects that a chain has failed to produce a block for a period of time, it will automatically exit and restart. This is to prevent the watch-tower from getting stuck on when a chain is not producing blocks.

## Package architecture

### Containers

1. `watch-tower` - the sole container. This container inherits from [upstream's GitHub packages repository](https://github.com/cowprotocol/watch-tower/pkgs/container/watch-tower) and provides minor modifications, notably including `bash` and an `entrypoint.sh` script to facilitate automatic configuration based on the user's settings from the package's setup wizard.
