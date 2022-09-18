module Heart
  module Core
    class ConfigurationDSL
      attr_reader :config

      def initialize
        @config = {}
      end

      def method_missing(method_name, *args, &block)
        @config[method_name] = if block_given?
          Proc.new { |*args| block.call(*args) }
        else
          args.first
        end
      end
    end
  end
end
