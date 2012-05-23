# Feature Lookup

We can use +Find.feature+ to seach for requireable files from within
library load paths. The `feature` method returns relatvie paths
by default and automatically handles extensions --just like `require`.

    files = Find.feature('example')
    file  = files.first

The +find+ method returns path name relative to the load path.

    file.assert == 'example.rb'

We can use the `realtive` or `aboslute` options to get the full path.

    files = Find.feature('example', :absolute=>true)
    file  = files.first

    File.expand_path(file).assert == file
    file.assert.end_with?('example.rb')

