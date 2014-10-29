# This file can be run from anywhere and it will recreate the full paths of
# the files that were backed up. It takes the backup directory e.g.
# backbash_YYYY-MM-DD as the only command-line argument.

if [ $# -ne 1 ]; then
  echo "usage"
  exit 1
fi

rundir=$1
backupdir=$rundir/backup/
cd $backupdir
newroot=/
#cp ./* ./.[^.]* -r -v --parents --no-clobber $newroot
find . -type f -exec cp {} -r -v --parents --no-clobber $newroot \;
echo "Finished at: `date`"
echo "Files were not overwritten, so you may want to manually copy profile files such as ~/.bashrc that already were written by the operating system."
