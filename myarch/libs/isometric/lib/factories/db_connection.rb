# frozen_string_literal: true

require 'active_record'
module Isometric
  class DbConnection
    def self.connect!(config_key = nil)
      config = Isometric::Config.instance[config_key || Isometric::DEFAULT_DATABASE_KEY]
      ActiveRecord::Base.establish_connection(
        adapter: config[:adapter],
        host: config[:host],
        username: config[:username],
        password: config[:password],
        database: config[:database]
      )
    end
  end
end
