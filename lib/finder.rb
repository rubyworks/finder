# Finder (http://rubyworks.github.com/finder)
#
# (c) 2012 Rubyworks
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
#    1. Redistributions of source code must retain the above copyright notice,
#       this list of conditions and the following disclaimer.
#
#    2. Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES,
# INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
# FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
# COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
# NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR  SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
# OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
# EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

require 'finder/index'
require 'finder/find'

# TODO: Import is optional for the time bing.
#require 'finder/import'

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

