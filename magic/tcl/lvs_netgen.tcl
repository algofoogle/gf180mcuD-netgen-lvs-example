set layout [readnet spice $project.lvs.spice]
set source [readnet spice /dev/null]
# readnet spice /home/anton/ttsetup@ttihp26a/pdk/ciel/ihp-sg13g2/versions/cb7daaa8901016cf7c5d272dfa322c41f024931f/ihp-sg13g2/libs.ref/sg13g2_stdcell/spice/sg13g2_stdcell.spice $source
# readnet spice $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sg13g2_stdcell/spice/sg13g2_stdcell.spice $source
# readnet spice $::env(PDK_ROOT)/$::env(PDK)/libs.tech/ngspice/models/resistors_mod.lib
# readnet spice $::env(PDK_ROOT)/$::env(PDK)/libs.tech/ngspice/models/resistors_stat.lib
# readnet spice $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice $source
# readnet spice $::env(PDK_ROOT)/$::env(PDK)/libs.ref/gf180mcu_fd_sc_mcu7t5v0/spice/gf180mcu_fd_sc_mcu7t5v0.spice $source ;# Or 9t5.
readnet spice $::env(PDK_ROOT)/$::env(PDK)/libs.tech/klayout/tech/lvs/testing/unit/mos_devices/netlist/nfet_03v3.cdl $source
readnet spice $::env(PDK_ROOT)/$::env(PDK)/libs.tech/klayout/tech/lvs/testing/unit/mos_devices/netlist/pfet_03v3.cdl $source

if {$project eq "tt_um_algofoogle_analog_gf26a"} {

    # LVS the whole design.

    # Add spice files of analog block(s):
    # readnet spice ../xschem/simulations/nand.spice $source
    # readnet spice ../xschem/simulations/inv30x.spice $source
    # readnet spice ../xschem/simulations/nmosbank.spice $source
    # readnet spice ../xschem/simulations/pmosbank.spice $source
    # readnet spice ../xschem/simulations/rm4.spice $source ;# Dummy rmetal4 resistor for top-level shorts.

    # Add GL verilog of digital block(s) (i.e. flat file from LibreLane hardening):
    # readnet verilog ../verilog/gl/digital.pnl.v $source

    # Top-level abstract integration verilog:
    # readnet verilog ../src/LVS-project.v $source

    lvs "$layout $project" "$source $project" \
        ../magic/tcl/lvs_setup_script.tcl \
        $report_file \
        -blackbox 
    # \ -noflatten={sg13g2_tiehi}

} else {

    # LVS just a specific cell:

    if {($project eq "digital")} {
        # Load Verilog netlist:
        readnet verilog ../verilog/gl/$project.pnl.v $source
    # } elseif {($project eq "sg13g2_dfrbpq_1")} {
    #     # Dedicated test for this standard cell; will already be loaded by sg13g2_stdcell.spice
    } else {
        # Load SPICE netlist:
        readnet spice ../xschem/simulation/$project.spice $source
        # readnet spice ../magic/rhigh.spice $source
    }
    
    lvs "$layout $project" "$source $project" \
        ../magic/tcl/lvs_setup_script.tcl \
        $report_file \
        -blackbox
    # \ -noflatten={sg13g2_tiehi}

}

#TODO:
# Regenerate/replace controller.mag
# Check top mag & make sure no shorts
# Correct LVS-project.v
# Try running extraction
# Try running LVS
