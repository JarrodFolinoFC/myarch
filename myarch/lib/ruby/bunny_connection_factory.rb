require 'bundler/setup'
require 'bunny'
require_relative 'app_shared_config'

class BunnyConnectionFactor
  def self.get_bunny
    rabbit_config = AppsSharedConfig.new.rabbit_config

    conn ||= Bunny.new "amqps://#{rabbit_config["user"]}:#{rabbit_config["password"]}@#{rabbit_config["server"]}/#{rabbit_config["vhost"]}"
    conn.start
    conn
  end
end