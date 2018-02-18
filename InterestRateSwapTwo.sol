pragma solidity ^0.4.15;

/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */

library SafeMath {
  /**
  * @dev Multiplies two numbers, throws on overflow.
  */
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    if (a == 0) {
      return 0;
    }
    uint256 c = a * b;
    assert(c / a == b);
    return c;
  }
  /**
  * @dev Integer division of two numbers, truncating the quotient.
  */
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    // assert(b > 0); // Solidity automatically throws when dividing by 0
    uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return c;
  }
  /**
  * @dev Substracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).
  */
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    return a - b;
  }
  /**
  * @dev Adds two numbers, throws on overflow.
  */
  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }
}
contract interestRateSwapTwo {
 using SafeMath for uint256;
    string outputMessage;
    string outputContractStatus;
    address owner;
    address fixedRateBuyer;
    address variableRateBuyer;
    uint256 liborRate;
    uint256 variableRate;
    uint256 fixedRate;
    uint256 primeRate;
    uint256 nomMarketValue;
    uint256 fixedPayout;
    uint256 variablePayout;
    uint256 currentPayout;
    uint256 variableRateAndLibor;
    uint256 startNomMarketValue;
    uint256 totalPayout=0;


    mapping (address => uint) public balanceOwed;

 // Sets the contract details between each contract participant
 function interestRateSwapTwo(address _fixedRateBuyer, address _variableRateBuyer, uint256 _fixedRate, uint256 _variableRate, uint256 _liborRate, uint256 _nomMarketValue) public {
     owner = msg.sender;

     // Aggreed upon contract details between two parties
     liborRate = _liborRate;
     variableRate =  _variableRate;
     outputMessage = "No swap has been done yet";
     outputContractStatus = "Not Active";

     // Variable used to track nomMarketValue and the Payout to terminate contract once the payout is larger that the nomMarketValue
     startNomMarketValue = _nomMarketValue;

     // Multiply the market value by 100 since interest rates have been normalized by multipling by 100 to remove decimals
     nomMarketValue = _nomMarketValue*100;



     // Assign the values for the fixed rate buyer
     fixedRateBuyer = _fixedRateBuyer;
     fixedRate = _fixedRate;

     // Assign the values for the variable rate buyer
     variableRateBuyer = _variableRateBuyer;
     variableRateAndLibor = _variableRate + _liborRate;




 }

 //Only allow the creator of the project to set values
 modifier onlyOwner {
   require (msg.sender == owner);
   _;
 }

 //Set liborRate and update variableRate, libor rate comes out every day so a new payout needs to be calculated
 // based on the new libor rate.
 function setLiborRate(uint256 _liborRate) onlyOwner {
   liborRate = _liborRate;
   variableRateAndLibor = variableRate + liborRate;
 }

/** Calculates the payout to either the fixed or variable buyer
 * Contract expires when market value has gone down to 0,
 * since the payout gets subtracted from the total market value after each Libor rate update
 * Interest is calculated based on new libor rate
 */
  function calculateSwapPayment() public {
      fixedPayout = 0;
      variablePayout = 0;
      currentPayout = 0;
      fixedPayout = (nomMarketValue * fixedRate)/100;
      variablePayout = (nomMarketValue * variableRateAndLibor)/100;

     //Principle += Principle* InterestRateInteger/100;

    if(startNomMarketValue>=totalPayout){

      // Fixed Interest is higher so Variable Rate Wins
      if (fixedPayout > variablePayout) {
          currentPayout = fixedPayout - variablePayout;
          outputMessage = "Fixed Rate Buyer pays Variable Rate Buyer";
          balanceOwed[fixedRateBuyer] += (currentPayout/1000);
      }
       // Variable Interest is higher so Fixed Rate Wins
      if (variablePayout > fixedPayout) {
          currentPayout = variablePayout - fixedPayout;
          outputMessage = "Variable Rate Buyer pays Fixed Rate Buyer";
          balanceOwed[variableRateBuyer] += (currentPayout/1000);
      }
        // Variable and Fixed Payouts are Equal
      if (variablePayout == fixedPayout) {
          currentPayout = 0;
          outputMessage = "Variable Rate and Fixed Rate Payouts Netted Out";
      }

        totalPayout = totalPayout+(currentPayout/1000);
        outputContractStatus = "Active";
    } else {
        outputMessage = "Nominal Market Value is 0, Total Payout is greater than Nominal Market Value contract has expired";
        nomMarketValue = 0;
        outputContractStatus = "Active";
        //selfdestruct(owner);
    }


  }
 // Returns payout value of IRS contract to the Fixed or Variable Buyer
 function getContractPayout() constant public returns(string, uint256, uint256, uint256, uint256) {
    //Display current contract details/past payout of the last swap, and the current balanceOwed;
    return (outputMessage, currentPayout, startNomMarketValue, balanceOwed[fixedRateBuyer], balanceOwed[variableRateBuyer]);
 }
 // Returns what the contract details are between the two parties
 function getContractDetails() constant public returns (address, address, uint256, uint256, uint256, uint256, uint256) {
    return (fixedRateBuyer, variableRateBuyer, fixedRate, liborRate, variableRate, variableRateAndLibor, nomMarketValue);
 }

    function getContractStatus() constant public returns (uint256, uint256, string){
        return(startNomMarketValue,  totalPayout, outputMessage);
    }
}
