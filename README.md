# glusterfs_hardlinks
This is a bash script to find Orphaned GlusterFS GFID’s are hard links under the $BRICK/.glusterfs directory that point to an inode of a file that has been removed manually, outside of the GlusterFS control ie not via client operation or the CLI
The refernce fir this can be found at https://icicimov.github.io/blog/high-availability/GlusterFS-orphaned-GFID-hard-links 
The above script has two variables, first is the brick path and second is the files which will have broken hard links.
The second script can be used to delete all the files from the file that has the links.
