#!/bin/bash

i=0
while [ $i -le 100 ]
do
        /software/amber22/bin/cpptraj -p system.prmtop << EOF
        trajin system.md$i.rst
        trajout system.md$i.pdb pdb
        reference  system.md0.rst
        autoimage
        rms reference :1-451@CA,C,N,O
        strip :WAT
        strip :Na+
        strip :Cl-
        go
EOF
        ((i+=25))
done

mv system.md0.pdb system_0ns.pdb
mv system.md25.pdb system_25ns.pdb
mv system.md50.pdb system_50ns.pdb
mv system.md75.pdb system_75ns.pdb
mv system.md100.pdb system_100ns.pdb
