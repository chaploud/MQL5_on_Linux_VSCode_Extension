// @brief Account Properties for the function `AccountInfoDouble()`
enum ENUM_ACCOUNT_INFO_DOUBLE {
  ACCOUNT_BALANCE, // Account balance in the deposit currency
  ACCOUNT_CREDIT, // Account credit in the deposit currency
  ACCOUNT_PROFIT, // Current profit of an account in the deposit currency
  ACCOUNT_EQUITY, // Account equity in the deposit currency
  ACCOUNT_MARGIN, // Account margin used in the deposit currency
};

/**
 * @brief Returns the value of the appropriate account property.
 * @param[in] property_id Property identifier. The value can be one of the values of `ENUM_ACCOUNT_INFO_DOUBLE`
 * @return Value of double type
 */
double AccountInfoDouble(
  ENUM_ACCOUNT_INFO_DOUBLE property_id
);

// @brief Account Properties for the function `AccountInfoDouble()`
enum ENUM_ACCOUNT_INFO_INTEGER {
  ACCOUNT_LOGIN, // Account number
  ACCOUNT_TRADE_MODE, // Account trade mode
  ACCOUNT_LEVERAGE, // Account leverage
  ACCOUNT_LIMIT_ORDERS, // Maximum allowed number of active pending orders
  ACCOUNT_MARGIN_SO_MODE, // Mode for setting the minimal allowed margin
  ACCOUNT_TRADE_ALLOWED, // Allowed trade for the current account
  ACCOUNT_TRADE_EXPERT, // Allowed trade for an Expert Advisor
  ACCOUNT_MARGIN_MODE, // Margin calculation mode
  ACCOUNT_CURRENCY_DIGITS, // The number of decimal places in the account currency, which are required for an accurate display of trading results
  // An indication showing that positions can only be closed by FIFO rule. If the property value is set to true, then each symbol positions will be closed in the same order, in which they are opened, starting with the oldest one. In case of an attempt to close positions in a different order, the trader will receive an appropriate error.
  //
  // For accounts with the non-hedging position accounting mode (`ACCOUNT_MARGIN_MODE`!=`ACCOUNT_MARGIN_MODE_RETAIL_HEDGING`), the property value is always false.
  ACCOUNT_FIFO_CLOSE,
  ACCOUNT_HEDGE_ALLOWED, // Allowed opposite positions on a single symbol
};
