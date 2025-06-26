#!/bin/bash
set -e

CHAIN_ID="flora-1"
GENESIS_URL="https://raw.githubusercontent.com/meta-flora/florachain-testnet/main/genesis.json"
SEEDS="d2babfd77827adb838012875a19eaa13c41f3b5b@3.16.81.157:26656"
KEY_NAME="${1:-validator1}"
DELEGATION="500000000uflora"

echo "🌿 Initializing Florachain validator node..."
wasmd init "$KEY_NAME-node" --chain-id "$CHAIN_ID" --overwrite

echo "📦 Downloading genesis..."
curl -s "$GENESIS_URL" > ~/.wasmd/config/genesis.json

echo "🔑 Generating validator key: $KEY_NAME"
wasmd keys add "$KEY_NAME" --keyring-backend test

echo "💰 Adding genesis account with $DELEGATION delegation"
wasmd genesis add-genesis-account \
  "$(wasmd keys show "$KEY_NAME" -a --keyring-backend test)" \
  "$DELEGATION" --keyring-backend test

echo "📝 Creating gentx..."
wasmd genesis gentx "$KEY_NAME" "$DELEGATION" \
  --chain-id "$CHAIN_ID" --keyring-backend test

echo "📥 Collecting gentxs..."
wasmd genesis collect-gentxs

echo "🔧 Configuring seed node & gas price..."
sed -i 's/^seeds =.*/seeds = "'"$SEEDS"'"/' ~/.wasmd/config/config.toml
sed -i 's/^minimum-gas-prices =.*/minimum-gas-prices = "0.025uflora"/' ~/.wasmd/config/app.toml

echo "🚀 Your validator node is ready. Run this command in root testnet repo to update genesis:"
echo "cd <repo> && git add genesis.json gentx/*.json && git commit && git push"

echo "Then restart all nodes (including yours) with the updated genesis to activate validator."
