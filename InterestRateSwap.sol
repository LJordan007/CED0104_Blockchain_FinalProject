pragma solidity ^0.4.11;

contract InterestRateSwap {
  address clientA;
  address clientB;
  uint marketValue;
  uint fixedRate;
  uint primeRate;
  uint libor;
  uint variableRate;
  uint balanceOwing;
  string outputMessage;

  function InterestRateSwap(uint _marketValue, uint _fixedRate, uint _primeRate, uint _libor) {
      address clientA = msg.sender;
      //address clientB;
      marketValue = _marketValue;
      fixedRate = _fixedRate;
      primeRate = _primeRate;
      libor = _libor;
      variableRate = primeRate + libor;
    }

 // function setLibor(uint _libor) constant returns (uint) {
   // libor = _libor;
    //variableRate = primeRate * libor;
    //return libor;
  //}

  function getLibor() constant returns (uint) {
    return libor;
  }

  function getVariableRate() constant returns (uint) {
    return variableRate;
  }

  function getFixedRate() constant returns (uint) {
    return fixedRate;
  }

    function calculateSwap() returns (bool) {
      uint difference;

      uint clientAInterest = marketValue * fixedRate;
      uint clientBInterest = marketValue * variableRate;

      if (clientAInterest > clientBInterest) {
        //Send the difference to client B
        balanceOwing = clientAInterest - clientBInterest;
        outputMessage = "Client A owes client B";
      } else {
        //Send the difference to client A
        balanceOwing = clientBInterest - clientAInterest;
        outputMessage = "Client B owes client A";
      }

      return true;
    }

    function getOutputMessage() constant returns (string) {
        return outputMessage;
    }

    function getFinalBalance() constant returns (uint) {
        return balanceOwing;
    }

}
