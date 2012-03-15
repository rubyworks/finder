# RELEASE HISTORY

## 0.2.1 / 2012-03-15

Fix Gem finder so that is places spec in Array, and catches
error is gem is not found.

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

