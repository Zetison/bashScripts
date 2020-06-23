# bashScripts
A collection of miscellaneous bash scripts

## sedFiles
If the file sedFiles is located in $HOME/kode/bashScripts, the script can be used within another script using the following

```console
SED_VARIABLES="foo1 foo2 foo3 foo4" # Variables to be found and replaced in the files in DICTS
DICTS="file1 file2 file3"           # Files in which to perform sed
source $HOME/kode/bashScripts/sedFiles
```
