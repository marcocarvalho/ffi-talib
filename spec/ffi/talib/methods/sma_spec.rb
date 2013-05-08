require 'spec_helper'

describe Talib do
  subject { Talib }
  it 'should call simple moving average' do
    subject.ta_sma([1,2,3,4,5,6,7,8,9,10], 3).should == [2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0]
  end

  it 'should return empty array if an empty one is given' do
    subject.ta_sma([], 2).should == []
  end

  it 'should raise error if no array is given' do
    expect { subject.ta_sma(nil, 2) }.to raise_error('prices must be an array')
  end

  it 'should raise error if period not a fixnum or not greater than 1' do
    expect { subject.ta_sma([], nil) }.to raise_error('period must be a Fixnum and greater than 1')
    expect { subject.ta_sma([], 1)}.to raise_error('period must be a Fixnum and greater than 1')
  end
end