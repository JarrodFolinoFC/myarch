# frozen_string_literal: true
require 'pry'
module Isometric
  class ConfigurationDSL
    attr_reader :config, :namespace, :namespace_stack

    def initialize
      @config = {}
      @namespace = @config
      @namespace_stack = []
    end

    def nested(name, &block)
      @namespace_stack = @namespace_stack + [name]
      # build_namespace
      @config[name] = {} unless @config[name]
      @namespace = @config[name]
      block.call
      @namespace_stack = @namespace_stack[0, @namespace_stack.size - 1] unless @namespace_stack.size == 0
      @namespace = @config
    end

    def build_namespace
      config = {}
      namespace_stack = [:a, :b, :c, :d]
      namespace_stack.size.times do |num|

        if num == 0
          config[namespace_stack.first] = {} unless config[namespace_stack.first]
        elsif num == 1
          config[namespace_stack.first][namespace_stack[1]] = {} unless config[namespace_stack.first][namespace_stack[1]]
        elsif num == 2
          config[namespace_stack.first][namespace_stack[1]][namespace_stack[2]] = {} unless config[namespace_stack.first][namespace_stack[1]][namespace_stack[2]]
        elsif num == 3
          config[namespace_stack.first][namespace_stack[1]][namespace_stack[2]][namespace_stack[3]] = {} unless config[namespace_stack.first][namespace_stack[1]][namespace_stack[2]][namespace_stack[3]]
        end
      end
      puts config.inspect
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
