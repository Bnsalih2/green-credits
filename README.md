# Green Credits Smart Contract

This repository contains a Clarity smart contract for managing carbon credits on the Stacks blockchain. The contract allows authorized minting, transferring, and retiring of carbon credits, measured in tons of CO₂ offset.

## Features

- **Minting:** Only the admin can mint new carbon credits to any account.
- **Transferring:** Users can transfer credits to other accounts.
- **Retiring:** Credits can be retired (burned) to permanently offset carbon.

## Contract Overview

- **Admin:** The contract deployer is set as the admin and is the only account allowed to mint new credits.
- **Balances:** Tracks the amount of credits each account holds.
- **Retired:** Tracks the amount of credits each account has retired.

## Usage

### Functions

- `mint(recipient, amount)`  
  Mint new credits to a recipient (admin only).

- `transfer(to, amount)`  
  Transfer credits from the sender to another account.

- `retire(amount)`  
  Retire credits from the sender’s balance.

### Read-Only Functions

- `get-admin()`  
  Returns the admin principal.

- `get-balance(account)`  
  Returns the balance of the specified account.

- `get-retired(account)`  
  Returns the retired credits of the specified account.

## Getting Started

1. **Clone the repository:**
   ```
   git clone https://github.com/your-username/green-credits.git
   ```

2. **Install dependencies:**  
   *(If using a testing framework or deployment tool, e.g., Clarinet)*
   ```
   clarinet install
   ```

3. **Deploy the contract:**  
   Follow your preferred Stacks deployment workflow.

## File Structure

- `contracts/green-credits.clar` — Main Clarity smart contract.
- `tests/` — Test files (if available).
- `.gitattributes` — Git attributes configuration.
