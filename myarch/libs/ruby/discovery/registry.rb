require 'json'
require 'fileutils'

module Heart
  module Core
    class Registry
      def initialize(registry_folder)
        @registry_folder = registry_folder
        mkdir!
      end

      def set(name, props)
        write!(name, props)
      end

      def get(name)
        read(name)
      end

      def delete(name) end

      private

      def read(name)
        file = File.read("#@registry_folder/#{name}.json")
        JSON.parse(file)
      end

      def write!(name, props)
        f = File.new("/Users/jarrod.folino/.registry/#{'s'}.json", 'w')
        f.write({}.to_json)
        f.close
        FileUtils.touch "/Users/jarrod.folino/.registry/#{'s'}.json"
        File.open("/Users/jarrod.folino/.registry/#{'s'}.json", 'w') { |f| f.write({}.to_json) }

      end

      def mkdir!
        dirname = File.dirname(@registry_folder)
        unless File.directory?(dirname)
          Dir.mkdir(@registry_folder)
        end
      end
    end
  end
end
