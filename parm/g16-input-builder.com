#!/bin/bash

name=MOL
charge=-1
nprocshared=12

cp ../MOL.pdb .

obabel -ipdb $name.pdb -oxyz -O $name.xyz

sed -e '1,2d' $name.xyz > $name.com
sed -i '1i\'%nprocshared=$nprocshared'' $name.com
sed -i '2i\#HF/6-31G* SCF=tight Pop=MK iop(6/33=2) iop(6/42=6) opt' $name.com
sed -i '3i \ ' $name.com
sed -i '4i \'$name' ' $name.com
sed -i '5i \ ' $name.com
sed -i '6i \'$charge' 1' $name.com
sed -i -e '$a\ ' $name.com

g09 $name.com &

exit
