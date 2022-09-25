# frozen_string_literal: true

module Isometric
  class ConfigurationDSL
    attr_reader :config

    def initialize
      @config = {}
    end

    def method_missing(method_name, *args, &block)
      @config[method_name] = if block_given?
                               proc { |*proc_args| block.call(*proc_args) }
                             else
                               args.first
                             end
    end
  end
end
