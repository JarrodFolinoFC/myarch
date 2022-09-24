require 'bunny'

module Heart
  module Core
    class BunnyConnectionFactory
      def self.conn(config_key = nil)
        config = Heart::Core::Config.instance[config_key || Heart::Core::DEFAULT_BUNNY_CONNECTION_KEY]
        cs = "amqps://#{config[:user]}:" \
      "#{config[:password]}" \
      "@#{config[:server]}" \
      "/#{config[:vhost]}"
        Bunny.new(cs)
      end
    end
  end
end
