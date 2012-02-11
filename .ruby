---
source:
- RUBY.yml
authors:
- name: Trans
  email: transfire@gmail.com
copyrights:
- holder: Rubyworks
  year: '2008'
  license: BSD-2-Clause
replacements: []
alternatives: []
requirements:
- name: detroit
  groups:
  - build
  development: true
dependencies: []
conflicts: []
repositories:
- uri: git://github.com/rubyworks/plugin.git
  scm: git
  name: upstream
resources:
  home: http://rubyworks.github.com/plugin
  code: http://github.com/rubyworks/plugin
  mail: http://groups.google.com/rubyworks-mailinglist
extra: {}
load_path:
- lib
revision: 0
name: finder
title: Finder
version: 1.2.0
summary: Robust library file locator
created: '2008-08-17'
description: Finder is a general purpose file finder for Ruby. Finder can search RubyGems,
  Roll libraries and Ruby's standard $LOAD_PATH and system data directory for the
  active or the most current library files. It is especially useful for implmenting
  library-based plugin systems.
organization: rubyworks
date: '2012-02-11'