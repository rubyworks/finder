[Homepage](http://rubyworks.github.com/finder) /
[Report Issue](http://github.com/rubyworks/finder/issues) /
[Source Code](http://github.com/rubyworks/finder)
( [![Build Status](https://secure.travis-ci.org/rubyworks/finder.png)](http://travis-ci.org/rubyworks/finder) )


# Finder

Finder is a straight-forward file finder for searching Ruby library paths.
It can handle RubyGems, Rolls and Ruby's standard site locals. It is both
more flexible and more robust the using Gem.find_files or searching the
$LOAD_PATH manually.


## Instructions

To find paths, simply provide a glob to the appropriate Finder function,
and it will return all matches found within current or most recent
versions of a library.

For example, a common use case for plug-in enabled application is to
require all the files found in library load paths:

    require 'finder'

    Find.feature('myapp/*').each do |file|
      require(file)
    end

This is basically equivalent to:

    Find.load_path('myapp/*.rb', :relative=>true).each do |file|
      require(file)
    end

Alternately you might load files only as needed. For instance, if a
command-line option calls for it.

In addition Finder has two optional Kernel extensions: `#import`
and `#import_relative`. These methods can be used like `#require`
and `#require_relative`, but load code directory into the 
current scope instead of the toplevel.

    require 'finder/import'

    module My
      import('abbrev.rb')
    emd

    My::Abbrev::abbrev(['ruby'])
    => {"rub"=>"ruby", "ru"=>"ruby", "r"=>"ruby", "ruby"=>"ruby"}

It is important to be careful when using `#import` to make sure loaded
scripts behave as intended. For example, if `abbrev.rb`  were to define
itself using `::` toplevel namespace indicators, i.e. `::Abbrev`, then
the above import would not work as demonstrated.


## Copyrights

Finder is copyrighted opensource software.

    Copyright (c) 2009 Rubyworks

It can be modified and redistributed in accordance with the terms of
the **BSD-2-Clause** license.

See LICENSE.txt file for details.
