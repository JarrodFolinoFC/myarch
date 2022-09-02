# frozen_string_literal: true

require 'bundler/setup'
require 'bunny'
require_relative '../config/app_shared_config'

class BunnyConnectionFactor
  def self.get_bunny
    @conn ||= Bunny.new(build_path(AppsSharedConfig.new.rabbit_config))
    @conn.start
    @conn
  end

  def self.build_path(rabbit_config)
    "amqps://#{rabbit_config['user']}:" \
      "#{rabbit_config['password']}" \
      "@#{rabbit_config['server']}" \
      "/#{rabbit_config['vhost']}"
  end
end
