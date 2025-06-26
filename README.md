# 🌿 Florachain Testnet

Welcome to **Florachain**, a Cosmos SDK testnet powered by [CosmWasm](https://cosmwasm.com) smart contracts and designed for experimentation, validator onboarding, and early development of decentralized apps using the `flora` token.

---

## 🚀 Quick Join (1-Liner)

To spin up a full node on any Linux-based cloud server (e.g., AWS EC2, DigitalOcean, Hetzner, GCP), just run:

```bash
curl -s https://raw.githubusercontent.com/meta-flora/florachain-testnet/main/join.sh | bash
```

> 🧠 This script initializes your node, downloads the genesis, configures peers, and starts syncing.

---

## 🔧 Network Details

| Parameter        | Value                                                                 |
|------------------|-----------------------------------------------------------------------|
| **Chain ID**     | `flora-1`                                                             |
| **Token**        | `flora` (denom: `uflora`)                                             |
| **Genesis**      | [`genesis.json`](https://raw.githubusercontent.com/meta-flora/florachain-testnet/main/genesis.json) |
| **Genesis Hash** | [Verify](https://raw.githubusercontent.com/meta-flora/florachain-testnet/main/genesis.sha256) |
| **Seed Node**    | `d2babfd77827adb838012875a19eaa13c41f3b5b@3.16.81.157:26656`          |
| **RPC Endpoint** | `http://3.16.81.157:26657`                                            |
| **Minimum Gas**  | `0.025uflora`                                                         |

---

## 🛠 Requirements

### ✅ Recommended Setup

- Ubuntu 22.04 or 24.04 LTS
- 2+ vCPUs, 4GB+ RAM
- 20GB+ disk (SSD-backed)
- Open ports: `26656`, `26657` (P2P & RPC)

### 🧱 Prerequisites

Install these packages before running the join script:

```bash
sudo apt update && sudo apt install -y build-essential git curl jq make
```

Install **Go 1.24+**:

```bash
wget https://go.dev/dl/go1.24.4.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.24.4.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> ~/.bashrc
source ~/.bashrc
go version  # should show 1.24.x
```

---

## 📥 Manual Join Instructions (Alternative)

```bash
# Clone Wasmd and build
git clone https://github.com/CosmWasm/wasmd
cd wasmd
git checkout v0.60.0
make install

# Initialize node
wasmd init floraval --chain-id flora-1

# Download genesis
curl -s https://raw.githubusercontent.com/meta-flora/florachain-testnet/main/genesis.json > ~/.wasmd/config/genesis.json

# Configure seed node
sed -i 's/^seeds =.*/seeds = "d2babfd77827adb838012875a19eaa13c41f3b5b@3.16.81.157:26656"/' ~/.wasmd/config/config.toml

# Set minimum gas price
sed -i 's/^minimum-gas-prices =.*/minimum-gas-prices = "0.025uflora"/' ~/.wasmd/config/app.toml

# Start node
wasmd start
```

---

## 🧱 Become a Validator

After syncing, you can submit a `gentx` and become a validator:

```bash
wasmd tx staking create-validator \
  --amount=500000000uflora \
  --pubkey=$(wasmd tendermint show-validator) \
  --moniker="your-moniker" \
  --chain-id=flora-1 \
  --commission-rate="0.10" \
  --commission-max-rate="0.20" \
  --commission-max-change-rate="0.01" \
  --min-self-delegation="1" \
  --from=your-key \
  --keyring-backend=test \
  --gas=auto --gas-adjustment=1.4 --yes
```

---

## 🤝 Contributing / Support

- GitHub: [meta-flora/florachain-testnet](https://github.com/meta-flora/florachain-testnet)
- Maintainer: [@j3robinson1](https://github.com/j3robinson1)

Pull requests, issues, and feedback welcome!

---
