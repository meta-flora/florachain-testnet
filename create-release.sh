#!/bin/bash
# Script to create GitHub release with binary

# Get the binary and files
cp /var/www/flora-downloads/florachaind ./florachaind
cp /var/www/flora-downloads/genesis.json ./genesis.json
cp /var/www/flora-downloads/florachaind.sha256 ./florachaind.sha256

# Create a tar.gz package
tar -czf florachain-peer-package.tar.gz florachaind genesis.json florachaind.sha256 peer-setup.sh

# Get version from binary
VERSION=$(./florachaind version 2>&1 | head -1 | cut -d' ' -f2)
if [ -z "$VERSION" ]; then
    VERSION="v1.0.0"
fi

echo "Creating release $VERSION..."
echo "Package: florachain-peer-package.tar.gz ($(du -h florachain-peer-package.tar.gz | cut -f1))"

# Create release using GitHub CLI (if available) or provide instructions
if command -v gh &> /dev/null; then
    gh release create $VERSION florachain-peer-package.tar.gz \
        --title "Flora Chain Peer Node Package $VERSION" \
        --notes "Complete package for joining Flora Chain testnet as a peer node.

**Contents:**
- florachaind: Flora Chain daemon binary
- genesis.json: Genesis file (chain-id: flora-1)
- florachaind.sha256: Binary checksum
- peer-setup.sh: Automated setup script

**Quick Start:**
\`\`\`bash
# Download and extract
wget https://github.com/meta-flora/florachain-testnet/releases/download/$VERSION/florachain-peer-package.tar.gz
tar -xzf florachain-peer-package.tar.gz
chmod +x peer-setup.sh
./peer-setup.sh
\`\`\`

**Main Node:**
- ID: 0fdd195eba262dbb1cf1e33f85ff5990722d93c6
- Address: testnet-gateway.metaflora.xyz:26656"
else
    echo "GitHub CLI not found. Please create release manually:"
    echo "1. Go to: https://github.com/meta-flora/florachain-testnet/releases/new"
    echo "2. Tag: $VERSION"
    echo "3. Title: Flora Chain Peer Node Package $VERSION"
    echo "4. Upload: florachain-peer-package.tar.gz"
fi
