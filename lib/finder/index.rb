module Finder

  #
  # Cached access to project metadata.
  #
  def index
    @index ||=(
      require 'yaml'
      file = File.expand_path('../finder.yml', File.dirname(__FILE__))
      YAML.load_file(file)
    )
  end

  #
  # Access to project metadata via constants.
  #
  # @example
  #   Finder::VERSION  #=> '0.2.0'
  #
  def const_missing(name)
    index[name.to_s.downcase] || super(name)
  end

end
