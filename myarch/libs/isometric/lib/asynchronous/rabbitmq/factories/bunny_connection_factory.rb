# frozen_string_literal: true

require 'bunny'

module Isometric
  class BunnyConnectionFactory
    class << self
      attr_reader :connections
    end

    def self.conn(isometric_lookup: nil, password: nil, server: nil, vhost: nil, user: nil)
      @connections ||= []
      config = Isometric::Config.instance[isometric_lookup || Isometric::DEFAULT_BUNNY_CONNECTION_KEY]
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
