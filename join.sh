#!/bin/bash
set -e

CHAIN_ID="flora-1"
GENESIS_URL="https://raw.githubusercontent.com/meta-flora/florachain-testnet/main/genesis.json"
SEEDS="d2babfd77827adb838012875a19eaa13c41f3b5b@3.16.81.157:26656"

echo "🌿 Initializing Florachain node (full node mode)…"
wasmd init floraval --chain-id "$CHAIN_ID" --overwrite

echo "🧹 Removing any validator key..."
rm -f ~/.wasmd/config/priv_validator_key.json

echo "📦 Downloading genesis file..."
curl -s "$GENESIS_URL" -o ~/.wasmd/config/genesis.json

echo "🔧 Configuring seed node & gas price..."
if [[ "$OSTYPE" == "darwin"* ]]; then
  sed -i '' 's/^seeds =.*/seeds = "'"$SEEDS"'"/' ~/.wasmd/config/config.toml
  sed -i '' 's/^minimum-gas-prices =.*/minimum-gas-prices = "0.025uflora"/' ~/.wasmd/config/app.toml
else
  sed -i 's/^seeds =.*/seeds = "'"$SEEDS"'"/' ~/.wasmd/config/config.toml
  sed -i 's/^minimum-gas-prices =.*/minimum-gas-prices = "0.025uflora"/' ~/.wasmd/config/app.toml
fi

echo "🚀 Starting Florachain node (full node, no validator vote)…"
wasmd start
