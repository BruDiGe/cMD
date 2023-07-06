#!/bin/bash

name=MOL
charge=-2
resname=MOL

antechamber -fi gout -fo ac -i $name.log -o $name.ac -c resp -at amber -pf y -nc $charge
prepgen -i $name.ac -o $name.prepi -f prepi -rn $resname

cp NEWPDB.PDB $resname"_g09.pdb"

#prepgen -i $name.ac -o $name.prepi -f prepi -m $name.mrc -rn $resname
parmchk2 -i $name.prepi -o $name.frcmod -f prepi -rn $resname

cp NEWPDB.PDB $resname"_prep.pdb"

cp $name.prepi ../.
cp $name.frcmod ../.

exit
