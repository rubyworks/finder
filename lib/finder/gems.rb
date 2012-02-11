module Finder

  # RubyGems finder methods.
  #
  module Gems
    extend self

    #
    # Search gems.
    #
    # @param [String] match
    #   The file glob to match.
    #
    # @param [Hash] options
    #   Search options.
    #
    # @return [Array<String>] List of absolute paths.
    #
    def path(match, options={})
      matches = []
      ::Gem::Specification.current_specs.each do |spec|
        list = []
        glob = File.join(spec.full_gem_path, match)
        list = Dir[glob] #.map{ |f| f.untaint }
        list = list.map{ |d| d.chomp('/') }
        matches.concat(list)
        # activate the library if activate flag
        lib.activate if options[:activate] && !list.empty?
      end
      matches
    end

    #
    # Search gem load paths.
    #
    # @param [String] match
    #   The file glob to match.
    #
    # @param [Hash] options
    #   Search options.
    #
    # @option options [true,false] :absolute
    #   Return absolute paths instead of relative to load path.
    #
    # @option options [true,false] :activate
    #   Activate the gems if it has matching files.
    #
    # @return [Array<String>] List of paths.
    #
    def load_path(match, options={})
      matches = []
      ::Gem::Specification.current_specs.each do |spec|
        list = []
        spec.require_paths.each do |path|
          glob = File.join(spec.full_gem_path, path, match)
          list = Dir[glob] #.map{ |f| f.untaint }
          list = list.map{ |d| d.chomp('/') }
          # return relative paths unless absolute flag
          if not options[:absolute]
            # the extra '' in File.join adds a '/' to the end of the path
            list = list.map{ |f| f.sub(File.join(spec.full_gem_path, path, ''), '') }
          end
          matches.concat(list)
        end
        # activate the library if activate flag
        lib.activate if options[:activate] && !list.empty?
      end
      matches
    end

    #
    # Search gem data paths.
    #
    # @param [String] match
    #   The file glob to match.
    #
    # @param [Hash] options
    #   Search options.
    #
    # @return [Array<String>] List of absolute paths.
    #
    def data_path(match, options={})
      matches = []
      ::Gem::Specification.current_specs.each do |spec|
        list = []
        glob = File.join(spec.full_gem_path, 'data', match)
        list = Dir[glob] #.map{ |f| f.untaint }
        list = list.map{ |d| d.chomp('/') }
        matches.concat(list)
        # activate the library if activate flag
        lib.activate if options[:activate] && !list.empty?
      end
      matches
    end

  end

end


module Gem

  # Search RubyGems for matching paths in current gem versions.
  #def self.search(match, options={})
  #  matches = []
  #  Gem::Specification.current_specs.each do |spec|
  #    glob = File.join(spec.lib_dirs_glob, match)
  #    list = Dir[glob] #.map{ |f| f.untaint }
  #    list = list.map{ |d| d.chomp('/') }
  #    matches.concat(list)
  #  end
  #  matches
  #end

  class Specification
    # Return a list of active specs or latest version of spec if not active.
    def self.current_specs
      named = Hash.new{|h,k| h[k] = [] }
      each{ |spec| named[spec.name] << spec }
      list = []
      named.each do |name, vers|
        if spec = vers.find{ |s| s.activated? }
          list << spec
        else
          spec = vers.max{ |a,b| a.version <=> b.version }
          list << spec
        end
      end
      return list
    end

    # Return full path of requireable file given relative path.
    def find_requireable_file(file)
      root = full_gem_path

      require_paths.each do |lib|
        base = File.join(root, lib, file)
        Gem.suffixes.each do |suf|
          path = "#{base}#{suf}"
          return path if File.file? path
        end
      end

      return nil
    end
  end

end

