require 'finder/find'
require 'finder/import'
require 'finder/index'

module Finder

  # Clean module that can be included elsewhere, to proved #path, #load_path
  # and #data_path methods without including the Gem, Roll, and Site constants.
  #
  module Findable
    def path(match, options={})
      Find.path(match, options)
    end

    def data_path(match, options={})
      Find.data_path(match, options)
    end

    def load_path(match, options={})
      Find.load_path(match, options)
    end

    def require_path(match, options={})
      Find.require_path(match, options)
    end

    def feature(match, options={})
      Find.feature(match, options)
    end
  end

end

module Find
  extend Finder::Find
end

