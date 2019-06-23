#!/bin/bash

### This script will take a selected file, batch of files or directory/directories from nemo,
### process all files with the extensions specified belos (case insensitive),
### and rename them to the desired format specified below.

### Copyright 2019, Walter Hüttenmeyer
###  This program is free software: you can redistribute it and/or modify
###     it under the terms of the GNU General Public License as published by
###     the Free Software Foundation, either version 3 of the License, or
###     (at your option) any later version.
### 
###     This program is distributed in the hope that it will be useful,
###     but WITHOUT ANY WARRANTY; without even the implied warranty of
###     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
###     GNU General Public License for more details.
### 
###     You should have received a copy of the GNU General Public License
###     along with this program.  If not, see <http://www.gnu.org/licenses/>.
###

 #SET HERE WHICH EXTENSIONS SHOULD BE PROCESSED - CASE INSENSITIVE
A_EXTENSIONS_TO_PROCESS="jpg jpeg arw cr2 raw"
 #SET THE FORMAT DESIRED HERE - SEE exiftool DOCUMENTATION FOR REFERENCE
STR_FORMAT="%Y%m%d_%H%M%S%%-c.%%le"


 #initialize variables empty
STR_EXIF_FILETYPES=""
 #create the corresponding exiftool extensions argument
for extension in ${A_EXTENSIONS_TO_PROCESS[@]}; do
	STR_EXIF_FILETYPES="${STR_EXIF_FILETYPES} -ext "$extension""
done

 #break the nemo file list array of one element into multiple newline-separated elements
mapfile -t A_FILES <<<"$NEMO_SCRIPT_SELECTED_FILE_PATHS"
 #remove last line, as nemo adds a newline at the end which will be empty
unset A_FILES[-1]
 
 #ask if its really intended
zenity --question --width=600 --text="Do you want to convert the filename of selected files?\n\
If a folder was selected, all sub-directories and files will be processed!"
 #if the dialog exited with something else than yes, exit
if [ $? -ne 0 ]; then
	exit 0;
else
	for i in "${A_FILES[@]}"; do
		exiftool -r "${STR_EXIF_FILETYPES}" '-filename<CreateDate' -d "${STR_FORMAT}" "$i"
	done
fi
