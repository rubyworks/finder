---
source:
- ruby.yml
authors:
- name: Trans
  email: transfire@gmail.com
copyrights:
- holder: Rubyworks
  year: '2009'
  license: BSD-2-Clause
replacements: []
alternatives: []
requirements:
- name: detroit
  groups:
  - build
  development: true
- name: qed
  groups:
  - test
  development: true
- name: ae
  groups:
  - test
  development: true
dependencies: []
conflicts: []
repositories:
- uri: git://github.com/rubyworks/plugin.git
  scm: git
  name: upstream
resources:
  home: http://rubyworks.github.com/finder
  code: http://github.com/rubyworks/finder
  mail: http://groups.google.com/rubyworks-mailinglist
extra: {}
load_path:
- lib
revision: 0
name: finder
title: Finder
version: 0.1.0
summary: Robust library file locator
created: '2009-11-24'
description: Finder is a general purpose file finder for Ruby. Finder can search RubyGems,
  Roll libraries and Ruby's standard $LOAD_PATH and system data directory for the
  active or the most current library files. It is especially useful for implmenting
  library-based plugin systems.
organization: rubyworks
date: '2012-02-11'
