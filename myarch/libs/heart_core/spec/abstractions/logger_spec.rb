require 'spec_helper'

RSpec.describe Heart::Core::Logger do
  it 'returns a new instance of a logger for the given class' do
    expect(Heart::Core::Logger.instance).to_not be_nil
  end
end
