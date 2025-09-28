# Flora-1 Testnet Source Code

This repository contains the source code for the Flora-1 testnet with CosmWasm support.

## Building the Binary

```bash
git clone https://github.com/meta-flora/florachain-testnet.git
cd florachain-testnet
go build -o florachaind ./cmd/florachaind
```

## Verification

```bash
# Check CosmWasm support
./florachaind query --help | grep wasm

# Verify build
sha256sum florachaind
```

## Network Information

- **Chain ID**: flora-1
- **CosmWasm**: v0.60.1 with wasmvm v2.2.4
- **Network**: Flora testnet

## Getting Genesis

```bash
curl -s <RPC_ENDPOINT>/genesis | jq -r '.result.genesis' > genesis.json
```
