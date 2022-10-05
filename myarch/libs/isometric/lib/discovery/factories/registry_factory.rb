# frozen_string_literal: true

module Isometric
  module Discovery
    class RegistryFactory
      def self.instance
        @instance ||= Isometric::Discovery::Registry.new(Redis.new)
      end
    end
  end
end
