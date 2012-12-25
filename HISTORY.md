# RELEASE HISTORY

## 0.4.0 / 2012-12-25

New release adds Kernel#import and #import_relative core extensions.
The methods load code directly into the calling scope, unlike 
the #require and #load methods which do so at the toplevel.

Changes:

* Add Kernel#import and #import_relative.
* Add dynamic project metadata lookup.


## 0.3.0 / 2012-05-22

This is a significant release in that the behavior of `Find.load_path` has
changed to return absolute paths by default. To get relative paths set
the `:relative` options to `true`. However, if you are doing that you
likely want to use the new `Find.feature` method which specifically searches
for requirable files and returns relative paths by default.

Changes:

* Find.load_path now returns absolute paths by default.
* Adds option `:relative=>true` to get relative paths.
* Adds new `Find.feature` for finding requirable files.
* New Base module provides shared methods to all systems.


## 0.2.1 / 2012-03-15

Fix Gem finder so that is places spec in Array, and catches
error if gem is not found.

Changes:

* Fix Gem finder :from option to collect Array of spec.
* Fix Gem finder to catch error when gem is not found.


## 0.2.0 / 2012-03-14

This release adds the `:from` option which allows searching
to be limited to a specific library/gem. It also fixes 
a bug with the Find.path method where one of the arguments
was mis-named.

Changes:

* Add support for `:from` option.
* Fix typo in `Find.path` arguments.


## 0.1.1 / 2012-02-11

Fixes a few oversites in last release.

Changes:

* Fix Find.data_path arguments.
* Add Roll.data_path method.


## 0.1.0 / 2012-02-11

Finder is a new library built from the ashes of the old Plugin gem.
Along with a new more fitting name, it has more robust and expanded
capabilites!

Changes:

* Happy Rebirthday!

