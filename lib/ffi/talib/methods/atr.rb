# TA_RetCode TA_ATR( int    startIdx,
#                    int    endIdx,
#                    const double inHigh[],
#                    const double inLow[],
#                    const double inClose[],
#                    int           optInTimePeriod, /* From 1 to 100000 */
#                    int          *outBegIdx,
#                    int          *outNBElement,
#                    double        outReal[] );

module FFI::Talib::Methods
  def ta_atr(high, low, close, opts = {})
    raise ArgumentError.new('prices must be an array') unless high.is_a?(Array) and low.is_a?(Array) and close.is_a?(Array)
    return [] if high.empty? or low.empty? or close.empty?

    inHigh       = FFI::Talib::LibC.malloc(DoubleSize * high.size)
    inLow        = FFI::Talib::LibC.malloc(DoubleSize * low.size)
    inClose      = FFI::Talib::LibC.malloc(DoubleSize * close.size)
    outReal      = FFI::Talib::LibC.malloc(DoubleSize * FFI::Talib::TA_ATR_Lookback(close.size))
    outBegIdx    = FFI::MemoryPointer.new(1.size)
    outNBElement = FFI::MemoryPointer.new(1.size)

    inHigh.write_array_of_double(high)
    inLow.write_array_of_double(low)
    inClose.write_array_of_double(close)

    ret = FFI::Talib::TA_ATR(0,close.size - 1, inHigh, inLow, inClose, close.size, outBegIdx, outNBElement, outReal)
    if ret == 0
      ret = outReal.read_array_of_double(outNBElement.read_int)
    else
      ret = false
    end
    FFI::Talib::LibC.free(inHigh)
    FFI::Talib::LibC.free(inLow)
    FFI::Talib::LibC.free(inClose)
    FFI::Talib::LibC.free(outReal)
    outBegIdx.free
    outNBElement.free
    ret
  end
end