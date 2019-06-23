# cinnamon-scripts
Scripts for use with nemo

# EXIF-rename
Especially useful when using a photo manager that doesn't rename files, like shotwell.<br>
Dragging multiple files with the same name (but located in different directories)<br>
from shotwell to a folder results in an inocmplete export, as they get overwritten.<br>
<br>
This script renames all selected images or images in the selected directory+subdirectories<br>
by default to the format %Y%m%d_%H%M%S%%-c.%%le (20190623_120416).<br>
A incrementing number (20190623_120416-1) will be added,<br>
if two pictures in the same directory were taken at the very same second.<br>
File types to process and format string can be set inside the script.<br>
Easiest use is on a directory before import.
