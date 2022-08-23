require 'active_record'
require 'yaml'

class Connection
  def self.connect
    ActiveRecord::Base.establish_connection(
      adapter: 'postgresql',
      host: 'tyke.db.elephantsql.com',
      username: 'tnemxqdp',
      password: 'DZVSYk6jNbXenJrVVhHHfhVRXk1KySbk',
      database: 'tnemxqdp'
    )
  end
end
