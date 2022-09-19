require 'spec_helper'

RSpec.describe Heart::Core::DbConnection do
  it 'uses the config from the Heart::Core::Config config with the key \'database\' by default' do
    Heart::Core::Config.instance.set_config('database') do
      adapter 'postgresql'
      host 'host.com'
      username 'username'
      password 'password'
      database 'password'
    end

    expect(ActiveRecord::Base).to receive(:establish_connection).
      with({ adapter: 'postgresql',
             host: 'host.com',
             username: 'username',
             password: 'password',
             database: 'password' }
      )
    described_class.connect!
  end

  it 'uses the config from the Heart::Core::Config config with a custom key' do
    Heart::Core::Config.instance.set_config('custom_key') do
      adapter 'postgresql2'
      host 'host.com2'
      username 'username2'
      password 'password2'
      database 'password2'
    end

    expect(ActiveRecord::Base).to receive(:establish_connection).
      with({ adapter: 'postgresql2',
             host: 'host.com2',
             username: 'username2',
             password: 'password2',
             database: 'password2' }
      )
    described_class.connect!('custom_key')
  end
end
