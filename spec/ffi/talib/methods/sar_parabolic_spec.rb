require 'spec_helper'

describe FFI::Talib do
  subject { FFI::Talib }
  let(:high) { [18.88, 18.82, 18.71, 18.86, 19.16, 19.35, 19.35, 19.55, 19.38, 19.20, 19.14, 18.97, 19.32, 19.58, 18.27, 16.76, 17.10, 17.02, 16.85] }
  let(:low)  { [18.48, 18.42, 18.46, 18.49, 18.68, 18.83, 18.84, 19.01, 18.60, 18.73, 18.63, 17.92, 18.16, 18.31, 17.22, 16.47, 16.48, 16.40, 16.55] }

  it 'should call simple moving average' do
    subject.ta_sar(high, low).should == [18.88, 18.8708, 18.861784, 18.42, 18.434800000000003, 18.471408000000004, 18.506551680000005, 18.569158579200003, 18.6, 18.6, 19.55, 19.517400000000002, 17.92, 19.58, 19.58, 19.455599999999997, 19.336176, 19.16000544]
  end

  it 'should return empty array if an empty one is given' do
    subject.ta_sar([], []).should == []
  end

  it 'should raise error if no array is given' do
    expect { subject.ta_sar(nil, nil) }.to raise_error('high and low prices must be an array')
  end
end



