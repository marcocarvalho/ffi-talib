# TA_RetCode TA_SAR( int    startIdx,
#                    int    endIdx,
#                    const double inHigh[],
#                    const double inLow[],
#                    double        optInAcceleration, /* From 0 to TA_REAL_MAX */
#                    double        optInMaximum, /* From 0 to TA_REAL_MAX */
#                    int          *outBegIdx,
#                    int          *outNBElement,
#                    double        outReal[] );

module FFI::Talib::Methods
  def ta_sar(high, low, opts = {})
    raise ArgumentError.new('high and low prices must be an array') unless high.is_a?(Array) and low.is_a?(Array)
    return [] if high.empty? or low.empty?
    options = {
      optInAcceleration: 0.02,
      optInMaximum: 0.2
    }.merge(opts)

    inHigh        = FFI::Talib::LibC.malloc(DoubleSize * high.size)
    inLow         = FFI::Talib::LibC.malloc(DoubleSize * low.size)
    outReal       = FFI::Talib::LibC.malloc(DoubleSize * high.size)
    outBegIdx     = FFI::MemoryPointer.new(1.size)
    outNBElement  = FFI::MemoryPointer.new(1.size)

    inHigh.write_array_of_double(high)
    inLow.write_array_of_double(low)

    ret = FFI::Talib::TA_SAR(0, high.size - 1, inHigh, inLow, options[:optInAcceleration], options[:optInMaximum], outBegIdx, outNBElement, outReal)
    if ret == 0
      ret = {}
      el = outNBElement.read_int
      ret   = outReal.read_array_of_double(el)
    else
      ret = false
    end
    FFI::Talib::LibC.free(inHigh)
    FFI::Talib::LibC.free(inLow)
    FFI::Talib::LibC.free(outReal)
    outBegIdx.free
    outNBElement.free
    ret
  end
end