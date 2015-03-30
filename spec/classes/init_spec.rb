require 'spec_helper'
describe 's3' do

  context 'with defaults for all parameters' do
    it { should contain_class('s3') }
  end
end
