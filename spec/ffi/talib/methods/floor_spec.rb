require 'spec_helper'

describe Talib do
  subject { Talib }
  it 'should call floor' do
    subject.ta_floor([1.2,2.3,3.6,4.4,5.5,6.8,7.2,8.1,9.1234,10.40]).should == [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0]
  end

  it 'should return empty array if an empty one is given' do
    subject.ta_floor([]).should == []
  end

  it 'should raise error if no array is given' do
    expect { subject.ta_floor(nil) }.to raise_error('prices must be an array')
  end
end