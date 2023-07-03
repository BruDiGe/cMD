#!/bin/bash

### script to change non-solvent residues in equilibration and heating

for i in eq?.in
do
 sed -i 's/XXX/224/g' $i 
 sed -i 's/XXX/224/g' h.in
done
