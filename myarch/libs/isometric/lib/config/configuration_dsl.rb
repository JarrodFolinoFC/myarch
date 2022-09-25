# frozen_string_literal: true

module Isometric
  class ConfigurationDSL
    attr_reader :config, :namespace

    def initialize
      @config = {}
      @namespace = @config
    end

    def nested(name, &block)
      @config[name] = {}
      @namespace = @config[name]
      block.call
      @namespace = @config
    end

    def method_missing(method_name, *args, &block)
      namespace[method_name] = if block_given?
                               proc { |*proc_args| block.call(*proc_args) }
                             else
                               args.first
                             end
    end
  end
end
