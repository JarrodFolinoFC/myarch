# frozen_string_literal: true

require 'logger'
module Isometric
  class Logger
    def self.instance(name = 'default')
      @loggers ||= {}
      @loggers[name] = ::Logger.new($stdout)
    end
  end
end
