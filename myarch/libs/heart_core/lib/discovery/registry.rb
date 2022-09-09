require 'redis'

module Heart
  module Core
    module Discovery
      class Registry
        def initialize
          @redis = Redis.new
        end

        def set(name, props)
          @redis.set(name, props)
        end

        def get(name)
          @redis.get(name)
        end

        def summary(prefix)
          filtered_keys = @redis.keys.find_all { |key| key.start_with?(prefix) }
          filtered_keys.inject({}) do |hash, key|
            hash[key] = get(key)
            hash
          end


        end

        def delete(name) end

      end
    end
  end
end

