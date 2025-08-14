# On-Chain Subscription Service

A simple Move smart contract for Aptos blockchain that enables on-chain subscription services.

## Features

- **Create Subscription Plans**: Service providers can create subscription plans with custom monthly fees
- **Subscribe to Plans**: Users can subscribe by paying the monthly fee in APT tokens
- **Automatic Payment**: Handles token transfers from subscribers to plan owners
- **Subscription Tracking**: Tracks subscription expiry, revenue, and subscriber count

## Smart Contract Functions

### `create_subscription_plan(owner: &signer, monthly_fee: u64)`
- Creates a new subscription plan
- Sets the monthly fee in APT tokens
- Initializes revenue and subscriber tracking

### `subscribe_to_plan(subscriber: &signer, plan_owner: address)`
- Allows users to subscribe to a plan
- Transfers monthly fee to plan owner
- Sets 30-day subscription period
- Updates revenue and subscriber metrics

## Contract Details

**Deployed Contract Address:**
'0x9c3e5f24d87fb2db7972e20e71cba501c426169beed886df384f160ae70b7071'
<img width="1818" height="878" alt="image" src="https://github.com/user-attachments/assets/ab05cf65-fea5-4b04-a0da-707df1402ab5" />

## Project Structure

```
subscription-service/
├── Move.toml          # Project configuration
├── sources/           # Smart contract source files
│   └── subscription.move
├── scripts/           # Deployment scripts
└── README.md          # This file
```

## Getting Started

### Prerequisites
- [Aptos CLI](https://aptos.dev/tools/aptos-cli/install-cli/)
- Aptos testnet/mainnet account with APT tokens

### Compilation
```bash
aptos move compile
```

### Testing
```bash
aptos move test
```

### Deployment
```bash
aptos move publish
```

## Usage Example

1. **Create a subscription plan**:
   ```bash
   aptos move run --function-id default::SubscriptionService::create_subscription_plan --args u64:1000000
   ```

2. **Subscribe to a plan**:
   ```bash
   aptos move run --function-id default::SubscriptionService::subscribe_to_plan --args address:PLAN_OWNER_ADDRESS
   ```

## Technical Details

- **Language**: Move
- **Blockchain**: Aptos
- **Token Standard**: AptosCoin (APT)
- **Subscription Duration**: 30 days
- **Framework**: Aptos Framework
