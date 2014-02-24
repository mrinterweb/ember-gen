require 'yaml'

module EmberGen
  module Support
    class Config
      CONFIG_DIR = File.join(File.dirname(__FILE__), 'configs')
      VENDOR_MAP = File.join(CONFIG_DIR, 'vendor_map.yml')

      attr_reader :hash

      def initialize(config)
        case config
        when :vendor_map
          @hash = load_yaml(VENDOR_MAP)
        else
          raise "Config mapping undefined for: #{config}"
        end
      end

      def load_yaml(file)
        YAML.load_file(file)
      end
    end
  end
end
