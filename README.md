# Introduction

This repository is for the LearnWeb3 Stacks bounty.

Using the Clarity-Bitcoin library, The main objective is to write a Clarity contract that mints a SIP-009 NFT to the sender of a bitcoin transaction using p2pkh addresses if the reciepient is the specified address

I would be implementing this as an NFT Ticketing system where buyers pay with bitcoin and recieve the corresponding ticket on the stacks blockchain.

The `contracts\nft_tickets` file is the implementation smart contract


## Verification of Bitcoin Transactions

The verification process confirms the condition that the recipient of the bitcoin is the contract owner and that 0.1 $BTC(10000000 satoshi) is sent
  
* verify-block-header
* verify-merkle-proof

## Walkthrough

As requirements, `clarinet` and `python` needs to be installed.

1. Deploy all contracts
```
clarinet integrate
```

2. Call deployment plan to send 0.1 BTC
```
clarinet deployments apply -p deployments/send-btc.devnet-plan.yaml --no-dashboard
```
3. Confirm to continue

4. Copy the tx hex from the Transaction

5. Press N to mine the block in the clarinet dashboard

6. execute the sell order by running the following command with the copied tx hex (replace 01..txhex). (The python script updates the deployment plan and calls the contract)
```
python ./src/executor.py 01..txhex
```

## Conclusion
