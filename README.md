# CED0104_Blockchain_FinalProject
This repo is the final project for the Blockchain course CED0104, which is an Interest Rate Swap contract

Authors of the Final Capstone Project:
Chris Stephens and Lawrence Jordan

There are two smart contracts that were created for this capstone project

## Smart Contract - InterestRateSwapOne.sol
This is just a simple Interest Rate Contract, that takes a fixed rate, variable rate, libor rate and two address from the two contract participants and calculates what the payout is.

  ## The functions that can be used with in this contract:
 * #### calculateSwapPayment: calculates the swap payout and determines who the winner is of the payout
 * #### getContractPayout: This displays the calculated payout for the either fixed or variable buyer of the contract after the calculateSwapPayment has been executed
 * #### getContractDetails: This displays the contract details of the swap of what were the aggred upon values of the contract

Values to be added in Create function below in Solidty to run this contract: Fixed Rate 4% is 400, Variable Rate 0.25% is 25, Libor Rate 5% is 500 and nominalge market value is 1000000

"0xca35b7d915458ef540ade6068dfe2f44e8fa733c", "0x14723a09acff6d2a60dcdf7aa4aff308fddc160c", "400", "25", "500", "1000000"


## Smart Contract - InterestRateSwapTwo.sol
   This contract takes a starting market value and calculates two interest rates againinst it, one that is fixed and the other that is a variable rate plus the libor rate. The contract expires once the total payouts are more than the inital starting market value of the contract.

   ## The functions that can be used with in this contract:
  * ### setDateSwapPayment: This function lets the owner of the contract set a Date based InterestRateSwap contract.
  * ### runDateSwapPayment: If setDateSwapPayment has been run with valid values, the owner of the contract could execute the Date InterestRateSwap contact.
  * #### calculateSwapPayment: this function calculates the winner of the new Libor rate entered
  * #### getContractPayout: This returns the last calculated payout from the calculateSwapPayment function, starting nominal market value of the contract, balanced paid out, and who gets paid the payout based on the new libor rate entered in the contract
  * #### setLiborRate: this allows for a new Libor rate to be entered, libor rates change daily so new rates need to be entered into the contract to calculate the end of day payout to either the fixed or variable owner of the contract    
  * #### getContractStatus: this returns the starting nominal market value of the contract, total payout of the contract to date and status
  * #### getContractPayout: This returns the last calculated payout, starting nominal market value of the contract, balanced paid out, and who gets paid the payout based on the new libor rate entered in the contract
  * #### balancedOwed: this is used to enter in either address of the contract participate to see the balance to date on what they have earned

Values to be added in Create function below in Solidty to run this contract: Fixed Rate 4% is 400, Variable Rate 0.25% is 25, Libor Rate 5% is 500 and nominalge market value is 1000000

"0xca35b7d915458ef540ade6068dfe2f44e8fa733c", "0x14723a09acff6d2a60dcdf7aa4aff308fddc160c", "400", "25", "500", "1000000"

#### Description of Interest Rate Swap

"What is an 'Interest Rate Swap'
An interest rate swap is an agreement between two counterparties in which one stream of future interest payments is exchanged for another based on a specified principal amount. Interest rate swaps usually involve the exchange of a fixed interest rate for a floating rate, or vice versa, to reduce or increase exposure to fluctuations in interest rates or to obtain a marginally lower interest rate than would have been possible without the swap."

From: https://www.investopedia.com/terms/i/interestrateswap.asp

https://ipfs.io/ipfs/QmXoypizjW3WknFiJnKLwHCnL72vedxjQkDDP1mXWo6uco/wiki/Interest_rate_swap.html
