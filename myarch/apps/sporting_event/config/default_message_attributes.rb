# frozen_string_literal: true

require 'securerandom'

Heart::Core::Config.instance.set_config('default/rabbit/attributes') do
  direct_name 'direct_one'
  routing_key 'routing_key_one'
  persistent true
  mandatory true
  # timestamp { Time.now }
  # expiration { Time.now }
  type 'type'
  reply_to ''
  content_type 'application/json'
  content_encoding ''
  priority 1
  message_id { SecureRandom.hex }
  correlation_id { SecureRandom.hex }
  # user_id 123
  app_id { Heart::Core::Config.instance['app']['app-name'] }
end
