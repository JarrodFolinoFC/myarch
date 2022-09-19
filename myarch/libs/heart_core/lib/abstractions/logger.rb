# frozen_string_literal: true

require 'logger'
module Heart
  module Core
    class Logger
      def self.instance(name = 'default')
        @loggers ||= {}
        @loggers[name] = ::Logger.new(STDOUT)
      end
    end
  end
end
