
require 'spec_helper'

describe Talib do
  subject { Talib }
  it 'should now all TALib methods implemented' do
    subject.respond_to?(:implemented_talib_methods).should be_true
    subject.implemented_talib_methods.is_a?(Array).should be_true
  end
end