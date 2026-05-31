# This script expects $cellname and $report_file to be set by the caller.

set layout [readnet spice $cellname.lvs.spice]  ;# "L": Overall SPICE netlist extracted from layout.
set schem  [readnet spice /dev/null]            ;# "S": Placeholder for schematic netlist; we'll add to it as needed, depending on what we're LVSing.

# Load SPICE netlist:
readnet spice ../xschem/simulation/$cellname.spice $schem
    
lvs "$layout $cellname" "$schem $cellname" \
    $::env(PDK_ROOT)/$::env(PDK)/libs.tech/netgen/$::env(PDK)_setup.tcl \
    $report_file \
    -blackbox
