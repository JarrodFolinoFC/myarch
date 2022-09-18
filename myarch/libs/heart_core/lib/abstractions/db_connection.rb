# frozen_string_literal: true

require 'active_record'
module Heart
  module Core
    class DbConnection
      def self.connect!
        config = Heart::Core::Config.instance['database']
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
