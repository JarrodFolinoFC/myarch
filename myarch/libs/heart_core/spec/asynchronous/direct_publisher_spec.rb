require 'spec_helper'

RSpec.describe Heart::Core::DirectPublisher do
  describe 'initialize' do
    before do
      @instance = described_class.new('queue_name')
    end

    {
      name: 'direct_name',
      queue_name: 'queue_name',
      settings: {}
    }.each do |prop, expected|
      it "sets the #{prop} to #{expected}" do
        expect(@instance.send(prop)).to eq(expected)
      end
    end
  end
end
