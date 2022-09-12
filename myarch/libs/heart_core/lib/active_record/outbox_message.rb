require 'active_record'

# frozen_string_literal: true
module Heart
  module Core
    class OutboxMessage < ActiveRecord::Base
    end
  end
end