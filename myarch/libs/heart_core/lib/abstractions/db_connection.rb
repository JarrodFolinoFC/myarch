# frozen_string_literal: true

require 'active_record'
module Heart
  module Core
    class DbConnection
      def self.connect!(config_key = nil)
        config = Heart::Core::Config.instance[config_key || Heart::Core::DEFAULT_DATABASE_KEY]
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
end
