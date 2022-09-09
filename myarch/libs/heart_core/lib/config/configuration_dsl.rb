module Heart
  module Core
    class ConfigurationDSL
      attr_reader :config

      def initialize
        @config = {}
      end

      def method_missing(method_name, *args)
        @config[method_name] = args.first
      end
    end
  end
end