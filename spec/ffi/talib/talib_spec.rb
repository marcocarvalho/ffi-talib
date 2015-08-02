
require 'spec_helper'

describe Talib do
  subject { Talib }
  it 'should now all TALib methods implemented' do
    expect(subject.respond_to?(:implemented_talib_methods)).to eq(true)
    expect(subject.implemented_talib_methods.is_a?(Array)).to eq(true)
  end
end
