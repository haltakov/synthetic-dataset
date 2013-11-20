import os, stat

#-------------#
# Import Vars #
#-------------#
Import('*')

#---------#
# Sources #
#---------#
src = []

for root, dirs, files in os.walk("."):
  if root.find('.svn') == -1:
    for file in [f for f in files if not f.endswith('~')]:
      src.append(os.path.join(root, file))
      install = env.Install(Dir(env.subst('$data_directory/'+root)), os.path.join(root, file))

#---------------------------------#
# Distribute to src_dir & bin_dir #
#---------------------------------#
#dist_files = ['SConscript'] + src

#env.Distribute (src_dir, dist_files)
#env.Distribute (bin_dir, src)

#Export(['env', 'src_dir', 'bin_dir'])

env.Alias('install', install)
