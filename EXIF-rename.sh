#!/bin/bash
 #break the list array of one element into multiple newline-separated elements
mapfile -t A_FILES <<<"$NEMO_SCRIPT_SELECTED_FILE_PATHS"
 #ask if its really intended
zenity --question --width=600 --text="Do you want to convert the filename of selected files?\n\
If a folder was selected, all subfiles will be processed!"
 #if the dialog exited with something else than yes, exit
if [ "$?" -ne 1 ]; then
	for i in "${A_FILES[@]}"
	do
		exiftool -r '-filename<CreateDate' -d %Y%m%d_%H%M%S%%-c.%%le "$i"
	done
else
	exit 1;
fi
exit 0
