# frozen_string_literal: true

module Isometric
  class RegistryFactory
    def self.instance
      @instance ||= Isometric::Discovery::Registry.new(Redis.new)
    end
  end
end