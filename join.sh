#!/bin/bash

CHAIN_ID="flora-1"
GENESIS_URL="https://raw.githubusercontent.com/meta-flora/florachain-testnet/main/genesis.json"
SEEDS="d2babfd77827adb838012875a19eaa13c41f3b5b@3.16.81.157:26656"

echo "🌿 Initializing Florachain node..."
wasmd init floraval --chain-id $CHAIN_ID

echo "📦 Downloading genesis file..."
curl -s $GENESIS_URL -o ~/.wasmd/config/genesis.json

echo "🔧 Setting seed node..."
if [[ "$OSTYPE" == "darwin"* ]]; then
  sed -i '' 's/^seeds =.*/seeds = "'"$SEEDS"'"/' ~/.wasmd/config/config.toml
  sed -i '' 's/^minimum-gas-prices =.*/minimum-gas-prices = "0.025uflora"/' ~/.wasmd/config/app.toml
else
  sed -i 's/^seeds =.*/seeds = "'"$SEEDS"'"/' ~/.wasmd/config/config.toml
  sed -i 's/^minimum-gas-prices =.*/minimum-gas-prices = "0.025uflora"/' ~/.wasmd/config/app.toml
fi

echo "🧹 Removing local validator key to avoid consensus conflict..."
rm -f ~/.wasmd/config/priv_validator_key.json

echo "🚀 Starting the node..."
wasmd start
