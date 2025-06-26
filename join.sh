#!/bin/bash

CHAIN_ID="flora-1"
GENESIS_URL="https://raw.githubusercontent.com/meta-flora/florachain-testnet/main/genesis.json"
SEEDS="d2babfd77827adb838012875a19eaa13c41f3b5b@3.16.81.157:26656"

echo "🌿 Initializing Florachain node..."
wasmd init floraval --chain-id $CHAIN_ID

echo "📦 Downloading genesis..."
curl -s $GENESIS_URL -o ~/.wasmd/config/genesis.json

echo "🔧 Setting seed node..."
sed -i 's/^seeds =.*/seeds = "'"$SEEDS"'"/' ~/.wasmd/config/config.toml

echo "⛽ Setting gas price..."
sed -i 's/^minimum-gas-prices =.*/minimum-gas-prices = "0.025uflora"/' ~/.wasmd/config/app.toml

echo "🚀 Starting node..."
wasmd start
