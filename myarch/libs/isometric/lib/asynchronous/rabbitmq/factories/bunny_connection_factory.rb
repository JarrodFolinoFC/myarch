# frozen_string_literal: true

require 'bunny'

module Isometric
  class BunnyConnectionFactory
    class << self
      attr_reader :connections
    end

    def self.conn(config_key = nil)
      @connections ||= []
      config = Isometric::Config.instance[config_key || Isometric::DEFAULT_BUNNY_CONNECTION_KEY]
      cs = "amqps://#{config[:user]}:" \
    "#{config[:password]}" \
    "@#{config[:server]}" \
    "/#{config[:vhost]}"
      bunny = Bunny.new(cs)
      @connections << bunny
      bunny
    end
  end
end
