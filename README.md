# Finder

[Homepage](http://rubyworks.github.com/finder) /
[Report Issue](http://github.com/rubyworks/finder/issues) /
[Development](http://github.com/rubyworks/finder) /
[Mailing List](http://groups.google.com/groups/rubyworks-mailinglist) /
[IRC Channel](irc://chat.us.freenode.net/rubyworks)

[![Build Status](https://secure.travis-ci.org/rubyworks/finder.png)](http://travis-ci.org/rubyworks/finder)


## DESCRIPTION

Finder is a straight-forward file finder for searching Ruby library paths.
It can handle RubyGems, Rolls and Ruby's standard site locals. It is both
more flexible and more robust the using Gem.find_files or searching the
$LOAD_PATH manually.


## INSTRUCTION

To find paths, simply provide a glob to the appropriate Finder function,
and it will return all matches found within current or most recent
versions of a library.

For example, a common use case for plug-in enabled application is to
require all the files found in library load paths:

    require 'finder'

    Find.feature('myapp/*.rb').each do |file|
      require(file)
    end

Alternately you might load files only as needed. For instance, if a
command-line option calls for it.


## COPYRIGHTS

Copyright (c) 2009 Rubyworks

Finder is release under the terms of the **BSD-2-Clause** license.

See LICENSE.txt file for details.

