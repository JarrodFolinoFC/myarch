module Isometric
  class BaseEventListener
    attr_reader :queue
    def initialize(queue, settings = nil)
      @queue = queue
      @settings = settings
    end
  end
end
