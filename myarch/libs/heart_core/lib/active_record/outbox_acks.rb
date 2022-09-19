# frozen_string_literal: true
require 'active_record'

module Heart
  module Core
    class OutboxAck < ActiveRecord::Base

    end
  end
end