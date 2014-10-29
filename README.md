backbash
========

Backup and restore file globs using bash scripts.

This collection of Bash scripts provides a pure command line utility for
backing up and restoring files. The files to be backed up are listed as file
globs in an input file and the three scripts perform the actions of finding all
matching files, copying to a specified backup directory, and restoring from the
backup directory.

The backup is NOT compressed.


installation
============

Requires:
 - Bash
 - grep
 - find

All dependencies are most likely installed by default on any linux installation
that uses Bash as the shell.


usage
=====

1. Create the list of file globs to be backed up.
Edit sources.txt to specify all inclusion and exclusion globs. The syntax is as
follows:
 - Any line beginning with # is ignored.
 - To include a glob, add a line with "I " followed by the glob, like:
   `I /path/to/include/*.txt`.
 - To exclude a glob, add a line with "X " followed by the glob, like:
   `X /path/to/exclude*.txt`.
Globs will be expanded by Bash.

2. Run list.sh to generate a list of exact filenames.
`./list.sh`
This will create a folder with a name like "selfback_<DATE>" where <DATE> is 
today's date. The folder will contain lists of files. You can manually review
these to ensure the globs in sources.txt worked correctly.

3. Run backup.sh to copy files.
`./backup.sh selfback_<DATE> <OUTDIR>` where <DATE> is the date of the selfback
directory generated in step 2 above and <OUTDIR> is the destination directory
to copy files.

4. Run restore.sh to copy files back.
`./restore.sh <OUTDIR>` where <OUTDIR> is the directory specified in step 3
above.
The files will be restored to their original locations on disk, using the full
path.

Please note that at this time permissions are NOT copied and existing 
files are NOT overwritten. If you are restoring configuration files, there may
be blank or default configuration files that were automatically created at
installation, and in order to restore your previously backed up configuration
you should either delete the defaults before running restore.sh or manually
copy the configuration files from their path in the directory "<OUTDIR>/backup". 

license
=======
GPL v3. See LICENSE for details. 
