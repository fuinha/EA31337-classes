//+------------------------------------------------------------------+
//|                                                EA31337 framework |
//|                       Copyright 2016-2019, 31337 Investments Ltd |
//|                                       https://github.com/EA31337 |
//+------------------------------------------------------------------+

/*
 * This file is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

// Properties.
#property strict

// Includes.
#include "Indicator.mqh"

/**
 * Class to deal with indicators.
 */
class Indi_OBV : public Indicator {

  // Structs.
  struct IndicatorParams {
    double foo;
  };
  // Struct variables.
  IndicatorParams params;

  public:

    /**
     * Class constructor.
     */
    void Indi_OBV(IndicatorParams &_params, ENUM_TIMEFRAMES _tf = NULL, string _symbol = NULL) {
      params = _params;
    }
    void Indi_OBV()
    {
    }

    /**
     * Returns the indicator value.
     *
     * @docs
     * - https://docs.mql4.com/indicators/iobv
     * - https://www.mql5.com/en/docs/indicators/iobv
     */
    static double iOBV(
        string _symbol,
        ENUM_TIMEFRAMES _tf,
        ENUM_APPLIED_PRICE _applied_price, // (MT4/MT5): PRICE_CLOSE, PRICE_OPEN, PRICE_HIGH, PRICE_LOW, PRICE_MEDIAN, PRICE_TYPICAL, PRICE_WEIGHTED
        int _shift = 0
        ) {
      #ifdef __MQL4__
      return ::iOBV(_symbol, _tf, _applied_price, _shift);
      #else // __MQL5__
      double _res[];
      int _handle = ::iOBV(_symbol, _tf, VOLUME_TICK);
      return CopyBuffer(_handle, 0, _shift, 1, _res) > 0 ? _res[0] : EMPTY_VALUE;
      #endif
    }
    double iOBV(
        ENUM_APPLIED_PRICE _applied_price,
        int _shift = 0) {
      double _value = iOBV(GetSymbol(), GetTf(), _applied_price, _shift);
      CheckLastError();
      return _value;
    }

};
