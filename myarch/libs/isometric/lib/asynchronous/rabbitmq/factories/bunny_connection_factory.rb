# frozen_string_literal: true

require 'bunny'

module Isometric
  class BunnyConnectionFactory
    def self.conn(config_key = nil)
      config = Isometric::Config.instance[config_key || Isometric::DEFAULT_BUNNY_CONNECTION_KEY]
      cs = "amqps://#{config[:user]}:" \
    "#{config[:password]}" \
    "@#{config[:server]}" \
    "/#{config[:vhost]}"
      Bunny.new(cs)
    end
  end
end
