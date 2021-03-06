module Talib::Methods
  def ta_floor(prices, opts = {})
    raise ArgumentError.new('prices must be an array') unless prices.is_a?(Array)
    return [] if prices.empty?
    # 8 is size of double in GCC linux, other SO got other sizes. For now it will be like this
    inReal       = Talib::LibC.malloc(8 * prices.size)
    outReal      = Talib::LibC.malloc(8 * prices.size) #Talib::TA_FLOOR_Lookback())
    outBegIdx    = FFI::MemoryPointer.new(1.size)
    outNBElement = FFI::MemoryPointer.new(1.size)

    inReal.write_array_of_double(prices)

    ret = Talib::TA_FLOOR(0,prices.size - 1, inReal, outBegIdx, outNBElement, outReal)
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