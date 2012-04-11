require 'hashr'
require 'yaml'

module ApplePush
  class Configuration < Hashr
    # Load a configuration options from file
    #
    # path - Path yo YAML file
    #
    def self.load_file(path)
      path = File.expand_path(path)

      if !File.exists?(path)
        raise ArgumentError, "File \"#{path}\" does not exist."
      end
      
      Configuration.new(YAML.load_file(path))
    end
  end
end
