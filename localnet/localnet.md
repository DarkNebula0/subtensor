# Bittensor Local Development Chain Setup

This guide will help you set up a local development chain for the Bittensor substrate chain with 4 pre-configured wallets. Follow the steps below to get started.

## Requirements
- Docker
- Bittensor-cli (for importing wallets)

## Setup Instructions

### Step 1: Build the Docker Image
Make sure you are in the root directory of the project. Then, build the Docker image from the `localnet.Dockerfile`:
```bash
docker build -t localnet:latest -f localnet.Dockerfile .
```
### Step 1: Build the Docker Image
Run the image and expose port 9944:
```bash
docker run --rm -p 9944:9944 localnet:latest
```
### Step 3: (Optional) Import the Wallets to Bittensor-CLI
Import the wallets using their mnemonics:
```bash
btcli wallet regen_coldkey --mnemonic "genius plate unique fun work release act picture rib hand surprise volume"
btcli wallet regen_coldkey --mnemonic "curious assume call save ocean field portion vocal nominee only sudden buddy"
btcli wallet regen_coldkey --mnemonic "tuna benefit solution labor remind aisle crucial olympic window imitate clip share"
btcli wallet regen_coldkey --mnemonic "march prison rebel antique ticket banana rebuild bid mobile empower afford acoustic"
```
### Step 4: (Optional) Inspect the Wallets and Check Balances
Inspect the new wallets and check their balances using Bittensor-CLI:
```bash
btcli wallet inspect --subtensor.chain_endpoint ws://127.0.0.1:9944
```
---

## Wallet Details
Every wallet has an amount of 3000 Tao.
### Wallet 1
- Mnemonic: `genius plate unique fun work release act picture rib hand surprise volume`
- Address(ss58): `5FAFCYALbRyFjcJFyBvixXKdYGcaWiQfk9WcgacJienwpRUG`
### Wallet 2
- Mnemonic: `curious assume call save ocean field portion vocal nominee only sudden buddy`
- Address(ss58): `5FZVBY5scevCRgP9Q8Y2GdwYGUvNL3T13t2XUvFXDDgnxtpo`
### Wallet 3
- Mnemonic: `tuna benefit solution labor remind aisle crucial olympic window imitate clip share`
- Address(ss58): `5DZHNF5RhWEDoecZFFtQHweLS7L5aViDrbjad47jeGz8GXtZ`
### Wallet 4
- Mnemonic: `march prison rebel antique ticket banana rebuild bid mobile empower afford acoustic`
- Address(ss58): `5GsHwAiWTjkhYg39ai5X2vhmAMCZwaixXRifYHJv42k4u8n7`
---

## Persisting Chain State

The provided Docker image contains a fixed chain state with 4 wallets that resets after each boot. If you want to persist the chain state, you can mount a volume to `/root` or mount the specific files:
- `/root/alice` - State for the Alice node
- `/root/bob` - State for the Bob node
- `/root/local_spec.json` - Current chain specification

If you want to persist the chain state across reboots, mount a volume to /root or the specific files for Alice, Bob, and the local chain specification as mentioned above.
