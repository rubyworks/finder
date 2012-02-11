# Plugin Demonstrandum

To use the Finder library first we need to require it.

    require 'finder'

Now use +Find.load+path+ to seach for a file pattern of our
choosing within library load paths.

    files = Find.load_path('example.rb')
    file  = files.first

The +find+ method returns path name relative to the load path.

    file.assert == 'example.rb'

We can use the `aboslute` option to get the full path.

    files = Find.load_path('example.rb', :absolute=>true)
    file  = files.first

    File.expand_path(file).assert == file
    file.assert.end_with?('example.rb')

As with any Ruby script we can require it.

    require Find.load_path('example.rb')

Our example.rb script defines the global variable $proof.
We can see that it loaded just fine.

    $proof.assert == "plugin loading worked"

