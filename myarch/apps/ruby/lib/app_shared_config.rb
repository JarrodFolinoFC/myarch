require 'yaml'

class AppsSharedConfig
  attr_reader :rabbit_config

  def initialize
    @rabbit_config = YAML.load_file("#{__dir__}/../../../config/rabbit.yml")
  end
end
