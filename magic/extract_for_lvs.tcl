set cellname [lindex $argv $argc-1]
box 0 0 0 0
load $cellname.mag
extract do local
extract all
ext2spice lvs
ext2spice cthresh infinite
ext2spice short resistor
ext2spice -d -o $cellname.lvs.spice
quit -noprompt
