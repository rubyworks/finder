module Finder
  module Find

    # Library finder methods.
    #
    module Roll
      extend self

      #
      # Search for current or latest files within a library.
      #
      # @param [String] match
      #   The file glob to match.
      #
      # @param [Hash] options
      #   Search options.
      #
      # @return [Array<String>] List of paths.
      #
      def path(match, options={})
        return [] unless defined?(::Library)
        matches = []
        ::Library.ledger.each do |name, lib|
          lib  = lib.sort.first if Array===lib
          find = File.join(lib.location, match)
          list = Dir.glob(find)
          list = list.map{ |d| d.chomp('/') }
          matches.concat(list)
        end
        matches
      end

      #
      # Search Roll system for current or latest library files. This is useful
      # for plugin loading.
      #
      # This only searches activated libraries or the most recent version
      # of any given library.
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
      #   Activate the library if it has matching files.
      #
      # @return [Array<String>] List of paths.
      #
      def load_path(match, options={})
        matches = []
        ::Library.ledger.each do |name, lib|
          list = []
          lib  = lib.sort.first if Array===lib
          lib.loadpath.each do |path|
            find = File.join(lib.location, path, match)
            list = Dir.glob(find)
            list = list.map{ |d| d.chomp('/') }
            # return relative load path unless absolte flag
            if not options[:absolute]
              # the extra '' in File.join adds a '/' to the end of the path
              list = list.map{ |f| f.sub(File.join(lib.location, path, ''), '') }
            end
            matches.concat(list)
          end
          # activate the library if activate flag
          lib.activate if options[:activate] && !list.empty?
        end
        matches
      end

      ## Search rolls for current or latest libraries.
      ##
      ##def load_path(match, options={})
      #  return [] unless defined?(::Library)
      #  #::Library.search_latest(match)
      #  ::Library.find_files(match)
      #end

      def data_path(match, options={})
        matches = []
        ::Library.ledger.each do |name, lib|
          list = []
          lib  = lib.sort.first if Array===lib
          find = File.join(lib.location, 'data', match)
          list = Dir.glob(find)
          list = list.map{ |d| d.chomp('/') }
          matches.concat(list)
          # activate the library if activate flag
          lib.activate if options[:activate] && !list.empty?
        end
        matches
      end

    end

  end
end
