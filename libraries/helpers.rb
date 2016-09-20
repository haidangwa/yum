module Helpers
  module_function

  @yum_cachedir = nil
  
  # it would be simple to reference node attributes here, but yum's global cachedir configuration
  # could contain yum variables are not understood outside of yum commands.
  def yum_cachedir
    return @yum_cachedir unless @yum_cachedir.nil?
  
    cmd = "python -c 'import yum, pprint; yb = yum.YumBase(); " \
      "pprint.pprint(yb.conf.cachedir, width=1)'"
    cachedir = Mixlib::ShellOut.new(cmd)
    cachedir.run_command
    cachedir.stdout.strip.delete("'")
  end
end

::Chef::Recipe.send(:include, Helpers)
