# frozen_string_literal: true

require 'yaml'
require 'pathname'

module Heart
  module Core
    class AppsSharedConfig
      attr_reader :rabbit_config

      def initialize
        @rabbit_config = YAML.load_file("#{root_dir}/config/rabbit.yml")
      end

      def root_dir
        dir = Pathname.getwd
        dir = dir.parent until File.exist?("#{dir}/.root")
        dir.to_s
      end
    end
  end
end