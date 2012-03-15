module Finder
  module Find

    # RubyGems finder methods.
    #
    module Gem
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
      # @option options [String] :from
      #   Specific gem to search.
      #
      # @return [Array<String>] List of absolute paths.
      #
      def path(match, options={})
        specs = specifications(options)

        matches = []
        specs.each do |spec|
          list = []
          glob = File.join(spec.full_gem_path, match)
          list = Dir[glob] #.map{ |f| f.untaint }
          list = list.map{ |d| d.chomp('/') }
          matches.concat(list)
          # activate the library if activate flag
          spec.activate if options[:activate] && !list.empty?
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
      # @option options [String] :from
      #   Specific gem to search.
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
        specs = specifications(options)

        matches = []
        specs.each do |spec|
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
          spec.activate if options[:activate] && !list.empty?
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
        specs = specifications(options)

        matches = []
        specs.each do |spec|
          list = []
          glob = File.join(spec.full_gem_path, 'data', match)
          list = Dir[glob] #.map{ |f| f.untaint }
          list = list.map{ |d| d.chomp('/') }
          matches.concat(list)
          # activate the library if activate flag
          spec.activate if options[:activate] && !list.empty?
        end
        matches
      end

    private

      def specifications(options)
        name = options[:from] || options[:gem]
        if name
          begin
            specs = [::Gem::Specification.find_by_name(name.to_s)]
          rescue ::Gem::LoadError
            return []
          end
        else
          ::Gem::Specification.current_specs
        end
      end

    end

  end
end


module Gem

  # Gem::Specification is extended to support `current_specs` method.
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

  end

end
