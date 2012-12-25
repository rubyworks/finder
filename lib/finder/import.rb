module Kernel

  private

  #
  # Evaluate script directly into current scope.
  #
  def import(feature)
    file = Find.feature(feature, :absolute=>true).first
    raise LoadError, "no such file -- #{feature}" unless file
    instance_eval(::File.read(file), file) if file
  end

  #
  # Evaluate script directly into current scope relative to
  # the current script.
  #
  # Note this is implemented via #caller.first.
  #
  def import_relative(fname)
    call = caller.first
    fail "Can't parse #{call}" unless call.rindex(/:\d+(:in `.*')?$/)
    path = $` # File.dirname(call)
    if /\A\((.*)\)/ =~ path # eval, etc.
      raise LoadError, "import_relative is called in #{$1}"
    end
    file = File.expand_path(fname, File.dirname(path))

    raise LoadError, "no such file -- #{file}" unless File.file?(file)

    instance_eval(::File.read(file), file) #if file
  end

end

