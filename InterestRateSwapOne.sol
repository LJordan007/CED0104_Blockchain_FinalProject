pragma solidity ^0.4.18;

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




contract interstRateSwapOne {

 using SafeMath for uint256;

    string outputMessage;
    address fixedRateBuyer;
    address variableRateBuyer;
    uint256 liborRate;
    uint256 variableRate;
    uint256 fixedRate;
    uint256 nomMarketValue;
    uint256 fixedPayout;
    uint256 variablePayout;
    uint256 balanceOwing;

 // Sets the contract details between each contract participant
 function interstRateSwapOne(address _fixedRateBuyer, address _variableRateBuyer, uint _fixedRate, uint _variableRate, uint _liborRate, uint _nomMarketValue) public {
     fixedRateBuyer = _fixedRateBuyer;
     variableRateBuyer = _variableRateBuyer;
     fixedRate = _fixedRate;
     variableRate = _variableRate;
     liborRate = _liborRate;
     nomMarketValue = _nomMarketValue;
 }


/** Calculates the payout to either the fixed or variable buyer based
 * Contract expires when market value has gone down to 0,
 * since the payout gets subtracted from the total market value after each Libor rate update
 */

  function calculateSwapPayment() public {
      fixedPayout=0;
      variablePayout=0;
      fixedPayout = nomMarketValue*fixedRate;
      variablePayout = nomMarketValue*(liborRate+variableRate);

      // Fixed Interest is higher so Variable Rate Wins
      if (fixedPayout > variablePayout) {
          balanceOwing = fixedPayout - variablePayout;
          outputMessage = "Fixed Rate Buyer pays Variable Rate Buyer";
      }

       // Variable Interest is higher so Fixed Rate Wins
      if (variablePayout > fixedPayout) {
          balanceOwing = variablePayout - fixedPayout;
          outputMessage = "Variable Rate Buyer pays Fixed Rate Buyer";
      }

        // Variable and Fixed Payouts are Equal
      if (variablePayout == fixedPayout) {
          balanceOwing = 0;
          outputMessage = "Variable Rate and Fixed Rate Payouts Netted Out";
      }

   nomMarketValue = nomMarketValue-balanceOwing;
  }

 // Returns payout value of IRS contract to the Fixed or Variable Buyer
 function getContractPayout() constant public returns(string, uint256, uint256) {
    // calculateSwapPayment;
      return (outputMessage, balanceOwing, nomMarketValue);
 }

 // Returns what the contract details are between the two parties
 function getContractDetails() constant public returns (address, address, uint, uint, uint, uint){
     return (fixedRateBuyer, variableRateBuyer, liborRate, fixedRate, variableRate, nomMarketValue);
 }


}
