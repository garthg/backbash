cd `dirname $0`
sources=sources.txt
rundir="selfback_`date +%Y-%m-%d`"
if [ ! -d $rundir ]; then
  mkdir -p $rundir
fi
outfile="$rundir/filelist.txt"
excludefile="$rundir/excludes.txt"
includefile="$rundir/includes.txt"
if [ -f $outfile ]; then
  rm $outfile
fi
echo '---'
cat $sources | sed 's/#.*//' | grep '^X ' | sed 's/^X //' > $excludefile
cat $sources | sed 's/#.*//' | grep '^I ' | sed 's/^I //' > $includefile
# Has problems with spaces in filename.
#for f in `cat $includefile`; do
while IFS= read -r line; do
  echo $line
  cmd="\
    find $line -type f | \
    grep -v \
    --file=$excludefile \
    "
  eval "$cmd" >> $outfile
done < "$includefile"
dufile=$rundir/du_output.txt
cat $outfile | tr '\n' '\0' | du -hc --files0-from - > $dufile
echo "File size list: $dufile"
cat $outfile | tr '\n' '\0' | du -c --files0-from - | tail -n 1
cat $dufile | tail -n 1
echo "Lines: `wc -l $dufile | awk '{ print $1 }'`"
echo 
echo "When ready, run: ./backup.sh $rundir <DEST>"
