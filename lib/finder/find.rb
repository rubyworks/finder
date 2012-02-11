require 'finder/roll'
require 'finder/gems'
require 'finder/site'

module Finder

  # Find module is the main interface.
  #
  module Find
    extend self

    # Find matching paths, searching through Rolled libraries, Gem-installed libraries
    # and site locations in `$LOAD_PATH` and `RbConfig::CONFIG['datadir']`.
    #
    # @param [String] match
    #   File glob to match against.
    #
    # @example
    #   Find.path('lib/foo/*')
    #
    def path(glob, options={})
      found = []
      systems.each do |system|
        found.concat system.path(match, options)
      end
      found.uniq
    end

    # Shortcut for #path.
    #
    #   Plugin['syckle/*']
    #
    alias_method :[], :path

    # Searching through Rolls, RubyGems and Site locations for matching
    # load paths.
    #
    # @param [String] match
    #   File glob to match against.
    #
    # @example
    #   Find.load_path('bar/*')
    #
    def load_path(match, options={})
      found = []
      systems.each do |system|
        found.concat system.load_path(match, options)
      end
      found.uniq
    end

    # Searching through Rolls, RubyGems and Site locations for matching
    # data paths.
    #
    # @param [String] match
    #   File glob to match against.
    #
    # @example
    #   Find.data_path('bar/*')
    #
    def data_path(glob)
      found = []
      systems.each do |system|
        found.concat system.data_path(match, options)
      end
      found.uniq
    end

    #
    def systems
      @systems ||= (
        Roll
        Gems
        Ruby
      )
    end

    # Search rolls for current or latest libraries.
    #
    def find_roll(match, options={})
      return [] unless defined?(::Roll) #Library
      #::Library.search_latest(match)
      ::Library.find_files(match)
    end

    # Search latest gem versions.
    #
    def find_gems(match, options={})
      return [] unless defined?(::Gem)
      ::Gem.search(match)
    end

    # Search standard $LOAD_PATH.
    #
    def find_site(match, options={})
      $LOAD_PATH.search(match)
    end

  end

end
