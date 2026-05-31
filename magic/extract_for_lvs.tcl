set cellname [lindex $argv $argc-1]     ;# Set 'cellname' variable to script's 1st argument.
box 0 0 0 0                             ;# Select a dummy box at (0,0) with no size.
load $cellname.mag                      ;# Load the .mag file at the location of the dummy box.
extract do local                        ;# Configure extraction to write to the local/current dir.
extract all                             ;# Perform extraction (producting .ext files).
ext2spice lvs                           ;# Configure ext2spice for doing LVS-specific conversion from .ext to .spice.
ext2spice cthresh infinite              ;# Prevent writing of parasitics capacitors (keep intentional capacitors only).
ext2spice short resistor                ;# Directly-connected nets should be preserved and shorted using 0R resistors.
ext2spice -d -o $cellname.lvs.spice     ;# Produce .spice file from .ext file now.
quit -noprompt
