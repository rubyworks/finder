module Finder
  module Find

    # Base module provides helper methods to other
    # finders.
    #
    module Base

      #
      # When included into a module, that module is atuomatically
      # self extended.
      #
      def self.included(mod)
        mod.extend(mod)
      end

      ##
      ## Like #load_path but searches only for requirable files.
      ##
      ## NOTE: This may be somewhat limited at the moment until we
      ## figure out how best to determine all possible extensions.
      ##
      #def require_path(match, options={})
      #  match = append_extensions(match, options)
      #  load_path(match, options)
      #end

      #
      # Like #load_path but searches only for requirable feature files
      # and returns relative paths by default.
      #
      def feature(match, options={})
        options[:relative] = true unless options.key?(:relative) or options.key?(:absolute)
        match = append_extensions(match, options)
        load_path(match, options)
      end

    private

      #
      # Validate and normalize load options.
      #
      # @param [Hash] options
      #
      def valid_load_options(options)
        if options.key?(:relative) && options.key?(:absolute)
          raise ArgumentError, "must be either relative or absolute" unless options[:relative] ^ options[:absolute]
        end

        options[:relative] = false if options[:absolute]

        options
      end

      #
      # Append requirable extensions to match glob.
      #
      #
      def append_extensions(match, options={})
        unless Find::EXTENSIONS.include?(File.extname(match))
          match = match + '{' + Find::EXTENSIONS.join(',') + '}'
        end
        match
      end

    end

  end
end
