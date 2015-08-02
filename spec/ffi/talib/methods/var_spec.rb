require 'spec_helper'

describe Talib do
  subject { Talib }
  it 'should call simple moving average' do
    expect(subject.ta_var([0,0,14,14])).to eq [49.0]
  end

  it 'should be possible to pass optional value for deviation' do
    expect(subject.ta_var([1,2,3,4])).to eq [1.25]
  end

  it 'should return empty array if an empty one is given' do
    expect(subject.ta_var([])).to eq []
  end

  it 'should raise error if no array is given' do
    expect { subject.ta_var(nil) }.to raise_error('prices must be an array')
  end
end
