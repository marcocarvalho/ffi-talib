require 'ffi'

module FFI::Talib
  module LibC
    extend FFI::Library
    ffi_lib FFI::Library::LIBC
    
    # memory allocators
    attach_function :malloc, [:size_t], :pointer
    attach_function :calloc, [:size_t], :pointer
    attach_function :valloc, [:size_t], :pointer
    attach_function :realloc, [:pointer, :size_t], :pointer
    attach_function :free, [:pointer], :void
    
    # memory movers
    attach_function :memcpy, [:pointer, :pointer, :size_t], :pointer
    attach_function :bcopy, [:pointer, :pointer, :size_t], :void
    
  end # module LibC

  extend FFI::Library
  ffi_lib '/usr/local/lib/libta_lib.so'

  attach_function :TA_SMA, [ :int, :int, :pointer, :int, :pointer, :pointer, :pointer], :uint

  def implemented_talib_methods
    methods.map { |n| v = n.to_s[0..2]; v = 'ta_' ? v[2, v.size].to_sym : nil }.compact
  end

  def ta_sma(prices, period, opts = {})
    inReal       = LibC.malloc(8 * prices.size)
    outReal      = LibC.malloc(8 * prices.size)
    outBegIdx    = FFI::MemoryPointer.new(1.size)
    outNBElement = FFI::MemoryPointer.new(1.size)
    
    inReal.write_array_of_double(prices)

    ret = TA_SMA(0,prices.size - 1, inReal, period, outBegIdx, outNBElement, outReal)
    if ret == 0
      ret = outReal.read_array_of_double(outNBElement.read_int)
    else
      ret = false
    end
    LibC.free(inReal)
    LibC.free(outReal)
    outBegIdx.free
    outNBElement.free
    ret
  end
end