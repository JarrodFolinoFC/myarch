require_relative 'configuration_dsl'

module Heart
  module Core
    class Config
      def self.instance
        @instance ||= Heart::Core::Config.new
      end

      def initialize
        @config = {}
      end

      def all
        @config
      end

      def [](key)
        @config[key]
      end

      def set_config(key, &block)
        return if @config.has_key?(key)
        @configuration_dsl = ConfigurationDSL.new
        @configuration_dsl.instance_eval(&block)

        @config[key] = @configuration_dsl.config
      end

      def set_app_config(&block)
        set_config('app', &block)
      end
    end
  end
end
