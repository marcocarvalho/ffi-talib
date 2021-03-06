module Talib::Methods

# TA_RetCode TA_STDDEV( int    startIdx,
#                       int    endIdx,
#                       const double inReal[],
#                       int           optInTimePeriod, /* From 2 to 100000 */
#                       double        optInNbDev, /* From TA_REAL_MIN to TA_REAL_MAX */
#                       int          *outBegIdx,
#                       int          *outNBElement,
#                       double        outReal[] );


  def ta_stddev(prices, opts = {})
    raise ArgumentError.new('prices must be an array') unless prices.is_a?(Array)
    return [] if prices.empty?

    optInTimePeriod = opts[:optInTimePeriod] || prices.size
    optInNbDev = opts[:optInNbDev] || 1

    inReal       = Talib::LibC.malloc(DoubleSize * prices.size)
    outReal      = Talib::LibC.malloc(DoubleSize * Talib::TA_STDDEV_Lookback(optInTimePeriod, optInNbDev))
    outBegIdx    = FFI::MemoryPointer.new(1.size)
    outNBElement = FFI::MemoryPointer.new(1.size)

    inReal.write_array_of_double(prices)

    ret = Talib::TA_STDDEV(0,prices.size - 1, inReal, optInTimePeriod, optInNbDev, outBegIdx, outNBElement, outReal)
    if ret == 0
      ret = outReal.read_array_of_double(outNBElement.read_int)
    else
      ret = false
    end
    Talib::LibC.free(inReal)
    Talib::LibC.free(outReal)
    outBegIdx.free
    outNBElement.free
    ret
  end
end