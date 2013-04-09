module FFI::Talib::Methods
  def ta_trima(prices, period, opts = {})
    raise ArgumentError.new('prices must be an array') unless prices.is_a?(Array)
    raise ArgumentError.new('period must be a Fixnum and greater than 1') if !period.is_a?(Fixnum) or period < 2
    return [] if prices.empty?

    inReal       = FFI::Talib::LibC.malloc(DoubleSize * prices.size)
    outReal      = FFI::Talib::LibC.malloc(DoubleSize * FFI::Talib::TA_TRIMA_Lookback(prices.size))
    outBegIdx    = FFI::MemoryPointer.new(1.size)
    outNBElement = FFI::MemoryPointer.new(1.size)

    inReal.write_array_of_double(prices)

    ret = FFI::Talib::TA_TRIMA(0,prices.size - 1, inReal, period, outBegIdx, outNBElement, outReal)
    if ret == 0
      ret = outReal.read_array_of_double(outNBElement.read_int)
    else
      ret = false
    end
    FFI::Talib::LibC.free(inReal)
    FFI::Talib::LibC.free(outReal)
    outBegIdx.free
    outNBElement.free
    ret
  end

end