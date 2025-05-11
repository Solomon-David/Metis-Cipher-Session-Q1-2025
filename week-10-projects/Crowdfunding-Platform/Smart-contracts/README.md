# Crowdfunding Smart Contracts

This repo implements a decentralized crowdfunding platform with two Solidity contracts:

- **CFContract**: A factory for deploying and managing individual projects.
- **Project**: Represents a single crowdfunding campaign.

## CFContract

Manages project creation and lookup.

### Key Functions
- `createProject(title, desc, target, currency)`: Deploys a new Project.
- `getAllProjects()`: Returns all project addresses.
- `getProjectsByCreator(addr)`: Lists projects by a user.
- `getProjectDetails(addr)`: Fetches project metadata.
- `logContribution(addr, amount)`: Records a contribution.
- `getTransactionCount(addr)`: Returns transaction count.
- `getTransaction(addr, index)`: Returns specific transaction details.

### Events
- `ProjectCreated(title, creator, address)`

---

## Project

Holds campaign data and contribution logs.

### Constructor
Initializes with title, description, target, and currency.

### Functions
- `activate()` / `deactivate()`: Toggle project status (owner only).
- `logPayment(amount)`: Adds a payment log.
- `getTransactionCount()`, `getTransaction(index)`: Fetch contributions.
- `getHighestContribution()`: Returns the largest contribution.
- `getProjectDetails()`: Returns full metadata.

### Event
- `PaymentLogged(contributor, amount, timestamp)`

---

##  Stack

- Solidity ^0.8.29  
- Hardhat + Nomic Toolbox  
- EVM-compatible (e.g. Ethereum, Metis Sepolia)

## License

MIT
