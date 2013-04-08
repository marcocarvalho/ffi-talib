# TA_RetCode TA_MACD( int    startIdx,
#                     int    endIdx,
#                     const double inReal[],
#                     int           optInFastPeriod, /* From 2 to 100000 */
#                     int           optInSlowPeriod, /* From 2 to 100000 */
#                     int           optInSignalPeriod, /* From 1 to 100000 */
#                     int          *outBegIdx,
#                     int          *outNBElement,
#                     double        outMACD[],
#                     double        outMACDSignal[],
#                     double        outMACDHist[] );

module FFI::Talib::Methods
  def ta_macd(prices, opts = {})
    raise ArgumentError.new('prices must be an array') unless prices.is_a?(Array)
    return [] if prices.empty?
    options = {
      optInFastPeriod: 12,
      optInSlowPeriod: 26,
      optInSignalPeriod: 9
    }.merge(opts)
    # 8 is size of double in GCC linux, other SO got other sizes. For now it will be like this
    inReal        = FFI::Talib::LibC.malloc(8 * prices.size)
    lookback      = FFI::Talib::TA_MACD_Lookback(options[:optInFastPeriod], options[:optInSlowPeriod], options[:optInSignalPeriod])
    outMACD       = FFI::Talib::LibC.malloc(8 * prices.size)#8 * lookback)
    outMACDSignal = FFI::Talib::LibC.malloc(8 * prices.size)#8 * lookback)
    outMACDHist   = FFI::Talib::LibC.malloc(8 * prices.size)#8 * lookback)
    outBegIdx     = FFI::MemoryPointer.new(1.size)
    outNBElement  = FFI::MemoryPointer.new(1.size)

    inReal.write_array_of_double(prices)

    ret = FFI::Talib::TA_MACD(0,prices.size - 1, inReal, options[:optInFastPeriod], options[:optInSlowPeriod], options[:optInSignalPeriod], outBegIdx, outNBElement, outMACD, outMACDSignal, outMACDHist)
    if ret == 0
      ret = {}
      el = outNBElement.read_int
      ret[:macd]   = outMACD.read_array_of_double(el)
      ret[:hist]   = outMACDHist.read_array_of_double(el)
      ret[:signal] = outMACDSignal.read_array_of_double(el)
    else
      ret = false
    end
    FFI::Talib::LibC.free(inReal)
    FFI::Talib::LibC.free(outMACD)
    FFI::Talib::LibC.free(outMACDHist)
    FFI::Talib::LibC.free(outMACDSignal)
    outBegIdx.free
    outNBElement.free
    ret
  end
end