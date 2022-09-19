# frozen_string_literal: true

require 'logger'
module Heart
  module Core
    class Logger
      def self.instance(klass)

        @log = Logging.logger[klass]
      end
    end
  end
end
