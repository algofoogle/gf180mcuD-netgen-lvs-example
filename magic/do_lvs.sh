#!/bin/bash

CELLNAME=inverter

MAGICRC=$PDK_ROOT/$PDK/libs.tech/magic/gf180mcuD.magicrc # aka $PDK_MAGICRC on my system.
MAGICEXEC="magic -rcfile $MAGICRC -noconsole -dnull"

# Layout extraction:
$MAGICEXEC extract_for_lvs.tcl $CELLNAME
rm -f *.ext

# Run netgen with script to do LVS compare:
netgen -batch eval "set cellname $CELLNAME ; set report_file lvs.report ; source lvs_netgen.tcl"

# Check LVS report and give feedback:
propOk=OK; match=FAIL; port=OK; # <= Assume these outcomes, until proven otherwise...
if grep -q "match uniquely"                             lvs.report; then match=OK;     fi
if grep -q "Property errors were found"                 lvs.report; then propOk=FAIL;  fi
if grep -q "failed pin matching"                        lvs.report; then match=FAIL;   fi
if grep -q "Final result: Netlists do not match"        lvs.report; then match=FAIL;   fi
if grep -q "port errors"                                lvs.report; then port=FAIL;    fi
if grep -q "Final result: Circuits match uniquely"      lvs.report; then match=OK;     fi
if [ "$match" == "OK" ] && [ "$propOk" == "OK" ] && [ "$port" == "OK" ]; then
    echo "LVS OK";
    exit 0;
else
    echo "LVS FAIL: match=$match properties=$propOk port=$port";
    exit 1;
fi
