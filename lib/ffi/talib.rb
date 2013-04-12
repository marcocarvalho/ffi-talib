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

  startIdx        = :int
  endIdx          = :int
  inReal          = :pointer
  optInTimePeriod = :int
  optInNbDev      = :double
  outBegIdx       = :pointer # to int
  outNBElement    = :pointer # to int
  outReal         = :pointer # array of double
  TA_RetCode      = :uint
  optInFastPeriod   = :int
  optInSlowPeriod   = :int
  optInSignalPeriod = :int
  outMACD           = :pointer
  outMACDSignal     = :pointer
  outMACDHist       = :pointer
  optInAcceleration = :double
  optInMaximum      = :double
  inHigh            = :pointer
  inLow             = :pointer
  inClose           = :pointer

# TA_RetCode TA_ATR( int    startIdx,
#                    int    endIdx,
#                    const double inHigh[],
#                    const double inLow[],
#                    const double inClose[],
#                    int           optInTimePeriod, /* From 1 to 100000 */
#                    int          *outBegIdx,
#                    int          *outNBElement,
#                    double        outReal[] );

  attach_function :TA_ATR, [startIdx, endIdx, inHigh, inLow, inClose, optInTimePeriod, outBegIdx, outNBElement, outReal], :uint
  attach_function :TA_ATR_Lookback, [optInTimePeriod], :int

  attach_function :TA_SAR, [startIdx, endIdx, inHigh, inLow, optInAcceleration, optInMaximum, outBegIdx, outNBElement, outReal], :uint
  attach_function :TA_SAR_Lookback, [optInAcceleration, optInMaximum], :int

  attach_function :TA_SMA, [ :int, :int, :pointer, :int, :pointer, :pointer, :pointer], :uint
  attach_function :TA_SMA_Lookback, [:int], :int

  attach_function :TA_FLOOR, [startIdx, endIdx, inReal, outBegIdx, outNBElement, outReal], TA_RetCode
  attach_function :TA_FLOOR_Lookback, [], :int

  attach_function :TA_TRIMA, [:int, :int, :pointer, :int, :pointer, :pointer, :pointer], :uint
  attach_function :TA_TRIMA_Lookback, [:int], :int

  attach_function :TA_STDDEV, [startIdx, endIdx, inReal, optInTimePeriod, optInNbDev, outBegIdx, outNBElement, outReal], :uint
  attach_function :TA_STDDEV_Lookback, [optInTimePeriod, optInNbDev], :int

  attach_function :TA_VAR, [startIdx, endIdx, inReal, optInTimePeriod, optInNbDev, outBegIdx, outNBElement, outReal], :uint
  attach_function :TA_VAR_Lookback, [optInTimePeriod, optInNbDev], :int

  attach_function :TA_MACD, [startIdx, endIdx, inReal, optInFastPeriod, optInSlowPeriod, optInSignalPeriod, outBegIdx, outNBElement, outMACD, outMACDSignal, outMACDHist], TA_RetCode
  attach_function :TA_MACD_Lookback, [optInFastPeriod, optInSlowPeriod, optInSignalPeriod], :int

  module Methods

    DoubleSize = 8

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