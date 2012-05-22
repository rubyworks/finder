module Finder
  module Find

    # System location finder methods.
    #
    module Site
      include Base

      #
      # System's data path.
      #
      DATA_PATH = RbConfig::CONFIG['datadir']

      # TODO: Might this support `:from` option via
      #       `File.join(options[:from], match)`?

      #
      # Search load path for matching patterns.
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
        return [] if options[:from]

        found = []
        $LOAD_PATH.uniq.map do |path|
          list = Dir.glob(File.join(File.expand_path(path), match))
          list = list.map{ |d| d.chomp('/') }
          found.concat(list)
        end
        found.concat(data_path(match, options))
        found
      end

      #
      # Search load path for matching patterns.
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
      # @return [Array<String>] List of paths.
      #
      def load_path(match, options={})
        return [] if options[:from]
        options = valid_load_options(options)

        found = []
        $LOAD_PATH.uniq.map do |path|
          list = Dir.glob(File.join(File.expand_path(path), match))
          list = list.map{ |d| d.chomp('/') }
          # return relative load path unless absolute flag
          if not options[:absolute]
            # the extra '' in File.join adds a '/' to the end of the path
            list = list.map{ |f| f.sub(File.join(path, ''), '') }
          end
          found.concat(list)
        end
        found
      end

      #
      # Search data path.
      #
      def data_path(match, options={})
        return [] if options[:from]

        Dir.glob(File.join(DATA_PATH, match)).uniq
      end

    end

  end
end
