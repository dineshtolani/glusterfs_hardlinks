# glusterfs_hardlinks
This is a bash script to find Orphaned GlusterFS GFID’s are hard links under the $BRICK/.glusterfs directory that point to an inode of a file that has been removed manually, outside of the GlusterFS control ie not via client operation or the CLI
