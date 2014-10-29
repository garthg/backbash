if [ $# -ne 2 ]; then
  echo "usage"
  exit 1
fi
rundir=$1
outdir=$2/`basename $rundir`
cd `dirname $0`
set -e
echo "Will write backup to: $outdir"
if [ ! -d $outdir ]; then
  mkdir -p $outdir || exit 1
fi
date > $outdir/timestamp.txt
dpkg -l > $outdir/dpkg_list.txt

metadir=$outdir/input
if [ ! -d "$metadir" ]; then mkdir $metadir; fi
cp $rundir/* $metadir/.

backupdir=$outdir/backup
if [ ! -d "$backupdir" ]; then mkdir $backupdir; fi
filelist=$rundir/filelist.txt
while IFS= read -r line; do
  echo $line
  cmd="cp --parents -u $(printf '%q' "$line") '$backupdir'"
  eval "$cmd"
done < "$filelist"
echo "Finished copying. Measuring resulting backup size..."
origdufile=$rundir/du_output.txt
dufile=$outdir/du_output.txt
du -hc $backupdir/* > $dufile
echo "File size list: $dufile"
echo "`cat $origdufile | tail -n 1` input disk usage"
echo "`cat $dufile | tail -n 1` measured disk usage on backup"
echo "`du -c $backupdir | tail -n 1` measured disk usage on backup in bytes"
echo "`wc -l $dufile` total files"
