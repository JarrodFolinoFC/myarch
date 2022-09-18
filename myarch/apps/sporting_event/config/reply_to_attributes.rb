# frozen_string_literal: true

require 'securerandom'

Heart::Core::Config.instance.set_config('rabbit/reply_to/publish_attributes') do
  # Publisher config
  direct_name 'direct_one'

  # standard bunny/rabbitmq properties
  routing_key 'routing_key_one'
  app_id { Heart::Core::Config.instance['app']['app-name'] }
end
