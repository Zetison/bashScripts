# bashScripts
A collection of miscellaneous bash scripts

## sedFiles
If the file sedFiles is located in $HOME/kode/bashScripts, the script can be used within another script using the following

```console
SED_VARIABLES="foo1 foo2 foo3 foo4" # Variables to be found and replaced in the files in DICTS
DICTS="file1 file2 file3"           # Files in which to perform sed
source $HOME/kode/bashScripts/sedFiles
```

## vimrc
In order to use the vim-settings in the vimrc file, perform the following (note that vim must be restartet in order for the configuration to take place)

```console
cp vimrc ~/.vimrc
```

## getNCEPdata
```console
$HOME/kode/bashScripts/getNCEPdata "20200701" "00 03 06"
```

## buildWRF
```console
$HOME/kode/bashScripts/buildWRF
```

