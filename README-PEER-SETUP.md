# Flora Chain Peer Node Setup

This repository contains everything needed to join the Flora Chain testnet as a peer node.

## Quick Start

### Option 1: Direct Download (Recommended)
```bash
curl -sSL https://testnet-gateway.metaflora.xyz/downloads/peer-setup.sh | bash
```

### Option 2: GitHub Release
```bash
curl -sSL https://testnet-gateway.metaflora.xyz/downloads/peer-setup-github.sh | bash
```

## Manual Setup

1. Download the peer package from [GitHub Releases](https://github.com/meta-flora/florachain-testnet/releases)
2. Extract: `tar -xzf florachain-peer-package.tar.gz`
3. Run: `chmod +x peer-setup.sh && ./peer-setup.sh`

## Network Information

- **Chain ID**: flora-1
- **Main Node ID**: 0fdd195eba262dbb1cf1e33f85ff5990722d93c6
- **Main Node Address**: testnet-gateway.metaflora.xyz:26656
- **RPC Endpoint**: https://testnet-gateway.metaflora.xyz:26657
- **GRPC Endpoint**: https://testnet-gateway.metaflora.xyz:9090

## Files Included

- `florachaind`: Flora Chain daemon binary
- `genesis.json`: Genesis file for flora-1 chain
- `florachaind.sha256`: Binary checksum for verification
- `peer-setup.sh`: Automated setup script

## Support

For issues or questions, please check the [Flora Chain documentation](https://testnet-gateway.metaflora.xyz/downloads/).
