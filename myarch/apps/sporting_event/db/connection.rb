# frozen_string_literal: true

require 'active_record'
require 'yaml'

class Connection
  def self.connect
    ActiveRecord::Base.establish_connection(
      adapter: 'postgresql',
      host: ENV['DB_HOST'] || 'tyke.db.elephantsql.com',
      username: ENV['DB_USERNAME'] || 'tnemxqdp',
      password: ENV['DB_PASSWORD'] || 'DZVSYk6jNbXenJrVVhHHfhVRXk1KySbk',
      database: ENV['DB_PASSWORD'] || 'tnemxqdp'
    )
  end
end
