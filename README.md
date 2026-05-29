# Minimal gf180mcuD LVS test

I'm having trouble getting Magic/Netgen LVS to work for a trivial example with the gf180mcuD PDK.

In this repo, you will find:

*   [./magic/inverter.mag](./magic/inverter.mag): Layout of a simple CMOS inverter (yes, I know typically the PFET should be bigger than the NFET). This layout is also exported to GDS: [./magic/inverter.gds](./magic/inverter.gds).
    *   [./magic/inverter.lvs.spice](./magic/inverter.lvs.spice): Corresponding extracted netlist for LVS.
*   [./xschem/inverter.sch](./xschem/inverter.sch): Xschem schematic for the same inverter.
    *   [./xschem/simulation/inverter.spice](./xschem/simulation/inverter.spice): Corresponding exported netlist for LVS.
*   [./magic/do_lvs.sh](./magic/do_lvs.sh): Script for doing extraction (using Magic) and LVS (using Netgen).
    *   Magic executes [./magic/extract_for_lvs.tcl](./magic/extract_for_lvs.tcl) to do the layout extraction.
    *   Netgen executes [./magic/lvs_netgen.tcl](./magic/lvs_netgen.tcl) to do the LVS comparison.
*   [./magic/do_lvs.log](./magic/do_lvs.log): Console output from running `do_lvs.sh`.
*   [./magic/lvs.report](./magic/lvs.report): Netgen LVS report showing `DEVICE mismatches` and `Netlists do not match`.

Versions:

```
$ magic --version
8.3.650

$ netgen -noconsole eval 'exit'
Netgen 1.5.320 compiled on Wed May 27 11:20:32 ACST 2026

$ xschem --version
XSCHEM V3.4.8RC

$ ciel ls
In /home/anton/ttsetup@ttgf26a/pdk/ciel/gf180mcu/versions:
├── 61a056e180dac7dcc6d4eb7529e2231f95105746 (2026.05.25) (enabled)
└── 54435919abffb937387ec956209f9cf5fd2dfbee (2025.12.26)
```

Environment variables:

```bash
PDK_ROOT=/home/anton/ttsetup@ttgf26a/pdk
PDK=gf180mcuD

ls -al $PDK_ROOT/$PDK
# /home/anton/ttsetup@ttgf26a/pdk/gf180mcuD -> ciel/gf180mcu/versions/61a056e180dac7dcc6d4eb7529e2231f95105746/gf180mcuD

ls -al $PDK_ROOT/$PDK/libs.tech/magic/PDK.magicrc  # aka $PDK_MAGICRC
# -rw-rw-r-- 1 anton anton 1997 May 27 13:52 /home/anton/ttsetup@ttgf26a/pdk/gf180mcuD/libs.tech/magic/gf180mcuD.magicrc
```
