require 'ffi'
require 'ffi/talib'

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

  startIdx     = :int
  endIdx       = :int
  inReal       = :pointer
  outBegIdx    = :pointer
  outNBElement = :pointer
  outReal      = :pointer
  TA_RetCode   = :uint

  attach_function :TA_SMA, [ :int, :int, :pointer, :int, :pointer, :pointer, :pointer], :uint
  attach_function :TA_SMA_Lookback, [:int], :int

  attach_function :TA_FLOOR, [startIdx, endIdx, inReal, outBegIdx, outNBElement, outReal], TA_RetCode
  attach_function :TA_FLOOR_Lookback, [], :int

  attach_function :TA_TRIMA, [:int, :int, :pointer, :int, :pointer, :pointer, :pointer], :uint
  attach_function :TA_TRIMA_Lookback, [:int], :int

  module Methods
    def implemented_talib_methods
      @implemented_talib_methods ||= methods.map { |n| v = n.to_s; v[0..2] == 'ta_' ? v[3, v.size].to_sym : nil }.compact
    end

    require 'ffi/talib/methods'
  end

  def self.included(klass)
    klass.extend(Methods)
    klass.send(:include, Methods)
  end

  extend Methods
end