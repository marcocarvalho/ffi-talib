require 'spec_helper'

describe Talib do
  subject { Talib }
  it 'should call simple moving average' do
    expect(subject.ta_stddev([0,0,14,14])).to eq [7.0]
  end

  it 'should be possible to pass optional value for deviation' do
    expect(subject.ta_stddev([0,0,14,14], optInNbDev: 2)).to eq [14.0]
  end

  it 'should return empty array if an empty one is given' do
    expect(subject.ta_stddev([])).to eq []
  end

  it 'should raise error if no array is given' do
    expect { subject.ta_stddev(nil) }.to raise_error('prices must be an array')
  end
end
