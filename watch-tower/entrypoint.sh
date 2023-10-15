#!/bin/bash

get_rpc() {
  local network="$1"

  # Convert network to uppercase
  network=$(echo "$network" | tr '[:lower:]' '[:upper:]')

  # Handle the case when the network is "goerli"
  if [ "$network" == "GOERLI" ]; then
    network="PRATER"
  fi

  local env_var_name="_DAPPNODE_GLOBAL_EXECUTION_CLIENT_$network"

  case "${!env_var_name}" in
    "geth.dnp.dappnode.eth")
      echo "http://geth.dappnode:8545"
      ;;
    "nethermind.public.dappnode.eth")
      echo "http://nethermind.public.dappnode:8545"
      ;;
    "erigon.dnp.dappnode.eth")
      echo "http://erigon.dappnode:8545"
      ;;
    "besu.public.dappnode.eth")
      echo "http://besu.public.dappnode:8545"
      ;;
    "goerli-geth.dnp.dappnode.eth")
      echo "http://goerli-geth.dappnode:8545"
      ;;
    "goerli-nethermind.dnp.dappnode.eth")
      echo "http://goerli-nethermind.dappnode:8545"
      ;;
    "goerli-besu.dnp.dappnode.eth")
      echo "http://goerli-besu.dappnode:8545"
      ;;
    "goerli-erigon.dnp.dappnode.eth")
      echo "http://goerli-erigon.dappnode:8545"
      ;;
    "nethermind-xdai.dnp.dappnode.eth")
      echo "http://nethermind-xdai.dappnode:8545"
      ;;
    "erigon-gnosis.dnp.dappnode.eth")
      echo "http://erigon-gnosis.dappnode:8545"
      ;;
    "")
      echo "Execution client (RPC) not configured for $network."
      exit 1
      ;;
    *)
      echo "Unknown value for $env_var_name: ${!env_var_name}"
      exit 1
      ;;
  esac
}

configure_chain() {
  local NETWORKS="$1"
  local CLI_ARGS=""

  if [ -n "$NETWORKS" ]; then
    IFS=',' read -ra NETWORKS_ARRAY <<< "$NETWORKS"

    for network in "${NETWORKS_ARRAY[@]}"; do
      rpc=$(get_rpc "$network")

      # Set deploymentBlock and watchdogTimeout based on the network
      case "$network" in
        "mainnet")
          deploymentBlock="17883049"
          watchdogTimeout="60"
          ;;
        "gnosis")
          deploymentBlock="29389123"
          watchdogTimeout="60"
          ;;
        "goerli")
          deploymentBlock="9493135"
          watchdogTimeout="120"
          ;;
        *)
          echo "Unknown network: $network"
          exit 1
          ;;
      esac

      CLI_ARGS="$CLI_ARGS --chain-config $rpc,$deploymentBlock,$watchdogTimeout"
    done

    echo "$CLI_ARGS"
  else
    echo "NETWORKS environment variable is not set."
  fi
}

extract_addresses() {
  local ADDRESSES="$1"
  local CLI_ARGS=""

  if [ -n "$ADDRESSES" ]; then
    IFS=',' read -ra ADDRESS_ARRAY <<< "$ADDRESSES"

    for address in "${ADDRESS_ARRAY[@]}"; do
      CLI_ARGS="$CLI_ARGS --address $address"
    done

    echo "$CLI_ARGS"
  fi
}

# Get the chain configuration
CHAIN_CONFIG=$(configure_chain "$NETWORKS")

# Get the processed address as CLI arguments
PROCESSED_ADDRESSES=$(extract_addresses "$ADDRESSES")

# Execute passing in public IP address and domain
exec /usr/local/bin/node ./dist/src/index.js \
    run-multi ${CHAIN_CONFIG} \
    $PROCESSED_ADDRESSES \
    ${EXTRA_OPTS}
