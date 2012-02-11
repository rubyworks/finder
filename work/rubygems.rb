if defined?(Gem)

  module Gem

    # Search RubyGems for matching paths in current gem versions.
    #
    # For RubyGems older than version 1.7 (actually I don't know
    # the exact cut-off, so let me know if you discover otherwise)
    # then this search will return matches from ALL gems.
    #
    # For RubyGems 1.7+ it returns matches ONLY from active gems or
    # the latest versions of non-active gems.
    #
    # The later is proper functionality. But the API on the old version
    # of RubyGems is not condusive, and worse, now docs for it are hard
    # to find.
    #
    def self.search(match, options={})
      return [] unless defined?(::Gem)
      if Gem::VERSION < '1.7'
        matches = Gem::find_files(match)
      else
        matches = []
        Gem::Specification.current_specs.each do |spec|
          glob = File.join(spec.lib_dirs_glob, match)
          list = Dir[glob] #.map{ |f| f.untaint }
          matches.concat(list)
        end
      end
      matches.map{ |d| d.chomp('/') }
    end

    class Specification
      # Return a list of actives specs, or latest version if not active.
      #
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

      # Return full path of requireable file given relative file name.
      # Returns +nil+ if there is no requirable file found by that name.
      #
      def find_requirable_file(file)
        root = full_gem_path

        require_paths.each do |lib|
          base = "#{root}/#{lib}/#{file}"
          Gem.suffixes.each do |suf|
            path = "#{base}#{suf}"
            return path if File.file? path
          end
        end

        return nil
      end
    end

  end

end
