Backbash
========

Author: Garth Griffin (http://garthgriffin.com)

Date: October 2014

Backup and restore file globs using bash scripts.

This collection of Bash scripts provides a pure command line utility for
backing up and restoring files. The files to be backed up are listed as file
globs in an input file and the three scripts perform the actions of finding all
matching files, copying to a specified backup directory, and restoring from the
backup directory. The backup is not compressed and is stored with fully
recreated filename paths so it can be easily browsed.


Installation
============

Requires:
 - Bash
 - grep
 - find

All dependencies are most likely installed by default on any linux installation
that uses Bash as the shell.


Usage
=====

1. Create the list of file globs to be backed up.  
Edit a file like sources_example.txt to specify all inclusion and exclusion
globs. The syntax is as follows:
 - Any line beginning with # is ignored.
 - To include a glob, add a line with "I " followed by the glob, like:  
   `I /path/to/include/*.txt`.
 - To exclude a glob, add a line with "X " followed by the glob, like:  
   `X /path/to/exclude*.txt`.
Globs will be expanded by Bash.

2. Run list.sh to generate a list of exact filenames.  
`./list.sh <SOURCES>` where SOURCES is the filename of sources from step 1.  
This will create a folder with a name like `backbash_<DATE>` where DATE is 
today's date. The folder will contain lists of files. You can manually review
these to ensure the globs in the SOURCES file worked correctly.

3. Run backup.sh to copy files.  
`./backup.sh backbash_<DATE> <OUTDIR>` where DATE is the date of the backbash
directory generated in step 2 above and OUTDIR is the destination directory
to copy files.

4. Run restore.sh to copy files back.  
`./restore.sh <OUTDIR>` where OUTDIR is the directory specified in step 3
above.
The files will be restored to their original locations on disk, using the full
path.

Please note that at this time permissions are NOT copied and existing 
files are NOT overwritten. If you are restoring configuration files, there may
be blank or default configuration files that were automatically created at
installation, and in order to restore your previously backed up configuration
you should either delete the defaults before running restore.sh or manually
copy the configuration files from their path in the directory `<OUTDIR>/backup`. 

Copyright and license
=======

This file and other files in this repository are part of Backbash.

Backbash is free software: you can redistribute it and/or modify it under the
terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) any later
version.

Backbash is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
Backbash. If not, see http://www.gnu.org/licenses/.

Please see the file LICENSE for the license text.

