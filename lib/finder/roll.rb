module Finder
  module Find

    # Finder methods for `Library` system.
    #
    module Roll
      include Base

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

        if from = options[:from]
          ledger = {from.to_s => ::Library.ledger[from.to_s]}
        else
          ledger = ::Library.ledger
        end

        criteria = [options[:version]].compact
        matches  = []

        ledger.each do |name, lib|
          if Array === lib
            lib = lib.select do |l|
              criteria.all?{ |c| l.version.satisfy?(c) }
            end
            lib = lib.sort.first
          else
            next unless criteria.all?{ |c| lib.version.satisfy?(c) }
          end
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
        return [] unless defined?(::Library)
        options = valid_load_options(options)

        if from = options[:from]
          libs = ::Library.ledger[from.to_s]
          if libs
            case libs
            when ::Array
              ledger = libs.empty? ? {} : {from.to_s => libs}
            else
              ledger = {from.to_s => libs}
            end
          else
            ledger = {}
          end
        else
          ledger = ::Library.ledger
        end

        criteria = [options[:version]].compact
        matches = []

        ledger.each do |name, lib|
          list = []
          if Array===lib
            lib = lib.select do |l|
              criteria.all?{ |c| l.version.satisfy?(c) }
            end
            lib = lib.sort.first
          else
            next unless criteria.all?{ |c| lib.version.satisfy?(c) }
          end
          lib.loadpath.each do |path|
            find = File.join(lib.location, path, match)
            list = Dir.glob(find)
            list = list.map{ |d| d.chomp('/') }
            # return relative load path unless absolute flag
            if options[:relative]
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

      #
      # Search project's data paths.
      #
      def data_path(match, options={})
        return [] unless defined?(::Library)

        if from = options[:from]
          ledger = {from.to_s => ::Library.ledger[from.to_s]}
        else
          ledger = ::Library.ledger
        end

        criteria = [options[:version]].compact
        matches = []

        ledger.each do |name, lib|
          list = []
          if Array === lib
            lib = lib.select do |l|
              criteria.all?{ |c| l.version.satisfy?(c) }
            end
            lib = lib.sort.first
          else
            next unless criteria.all?{ |c| l.version.satisfy?(c) }
          end
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
