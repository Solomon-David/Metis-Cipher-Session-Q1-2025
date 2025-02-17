# How to Verify Smart Contracts Deployed Via Hardhart on the Metis Blockchain

Verifying a contract means making its source code public, along with the compiler settings used, which allows anyone to compile it and compare the generated bytecode with the one deployed on-chain.

To verify smart contracts deployed via hardhat on the metis blockchain, we would be using the plugin, `hardhat-verify`. This plugin helps verify the source code for Solidity contracts and supports Etherscan-based explorers, explorers compatible with its API.

## Install Dependencies

Ensure that you have the necessary dependencies installed in your project.

```
npm install --save-dev @nomicfoundation/hardhat-verify
```

## Configure Hardhat for Metis

And add the following statement to your hardhat.config.js:

```
require("@nomicfoundation/hardhat-verify");
```

Or, if you are using TypeScript, add this to your hardhat.config.ts:

```
import "@nomicfoundation/hardhat-verify";
```

```
module.exports = {
  solidity: "0.8.20",
  networks: {
    metis: {
      url: "https://andromeda.metis.io/?owner=1088",
      chainId: 1088,  // Metis chain ID
      accounts: [process.env.PRIVATE_KEY]
    }
  },
  etherscan: {
    apiKey: {
      metis: process.env.METIS_SCAN_API_KEY
    },
    customChains: [
      {
        network: "metis",
        chainId: 1088,
        urls: {
          apiURL: "https://api.routescan.io/v2/network/mainnet/evm/1088/etherscan",
          browserURL: "https://andromeda-explorer.metis.io"
        }
      }
    ]
  }
};
```

## Set Up Environment Variables

In your `.env` file, store your private key and Metis Explorer API key:

```
PRIVATE_KEY=your_private_key_here
METIS_SCAN_API_KEY=your_metis_scan_api_key_here
```

You can get an API key from RouteScan by registering.

**Steps to Get a RouteScan API Key**

- Go to [RouteScan's Website](https://www.routescan.io/)

- Create an Account: If you don’t already have an account, you’ll need to sign up. Click on the "Sign Up" or "Get Started" button and provide the required details like your email and password.

- Log In to Your Account: After registering, log in to your account.

- Access API Key: Once logged in, navigate to the API Key section, which is usually available under your account settings or dashboard. Look for an option like "Generate API Key" or "API Keys".

- Generate API Key: Click on "Generate API Key" (or similar option) to create a new API key. Copy the generated API key.

- Store the API Key: Save the API key securely. You’ll need to use it in your Hardhat configuration (e.g., in the `.env` file) to verify contracts on RouteScan.


## Verify Your Contract

After deploying, you can verify your contract on Metis’ RouteScan using the following Hardhat command:

1. **Without constructor arguments:**

```
npx hardhat verify --network metis <DEPLOYED_CONTRACT_ADDRESS>
```

2. **With constructor arguments (if applicable):**

```
npx hardhat verify --network metis <DEPLOYED_CONTRACT_ADDRESS> "constructor_argument1" "constructor_argument2"
```

Make sure to replace `<DEPLOYED_CONTRACT_ADDRESS>` with the actual address of your deployed contract, and provide constructor arguments if your contract requires them.

## Check Verification Status

Once the verification process is complete, your contract should appear on Metis RouteScan (Andromeda Explorer). You can access it on [Metis Explorer](https://andromeda-explorer.metis.io).

Your contract’s source code will now be available for others to inspect and interact with directly from the explorer.
