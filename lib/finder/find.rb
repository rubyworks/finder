require 'finder/roll'
require 'finder/gem'
require 'finder/site'

module Finder

  # Find module is the main interface for Finder library.
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
    def data_path(match, options={})
      found = []
      systems.each do |system|
        found.concat system.data_path(match, options)
      end
      found.uniq
    end

    #
    # List of supported library management systems.
    #
    def systems
      @systems ||= (
        systems = []
        systems << Roll if defined?(::Library)
        systems << Gem  if defined?(::Gem)
        systems << Site
        systems
      )
    end

  end

end
