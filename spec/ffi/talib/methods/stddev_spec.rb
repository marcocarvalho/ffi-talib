require 'spec_helper'

describe FFI::Talib do
  subject { FFI::Talib }
  it 'should call simple moving average' do
    subject.ta_stddev([0,0,14,14]).should == [7.0]
  end

  it 'should be possible to pass optional value for deviation' do
    subject.ta_stddev([0,0,14,14], optInNbDev: 2).should == [14.0]
  end

  it 'should return empty array if an empty one is given' do
    subject.ta_stddev([]).should == []
  end

  it 'should raise error if no array is given' do
    expect { subject.ta_stddev(nil) }.to raise_error('prices must be an array')
  end
end