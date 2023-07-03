#!/bin/sh
#SBATCH --job-name=md_system
#SBATCH --partition=gpu
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16GB
#SBATCH --gres=gpu:1

# launch the cMD by: sbatch cmd.sh name-of-your-system
MOL=$1

source /software/amber20/amber.sh
export PMEMD=pmemd.cuda
export SANDER=sander.MPI
export mpirun="mpirun -np 4"

export PATH=/software/openmpi/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/software/openmpi/lib${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

export TMPDIR=/scratch/slurm_temp
export SLURM_TMPDIR=/scratch/slurm_temp
export SLURM_SUBMIT_DIR=$PWD

#1.- Minimization steps
$PMEMD -O -i min1.in -o $1.min1.out -p $1.prmtop -c $1.inpcrd -r $1.m1.rst -ref $1.inpcrd
$PMEMD -O -i min2.in -o $1.min2.out -p $1.prmtop -c $1.m1.rst -r $1.m2.rst -ref $1.m1.rst
$PMEMD -O -i min3.in -o $1.min3.out -p $1.prmtop -c $1.m2.rst -r $1.m3.rst -ref $1.m2.rst

#2.- Heating (100 --> 300K)
$PMEMD -O -i h.in -o $1.h.out -p $1.prmtop -c $1.m3.rst -r $1.h.rst  -ref $1.m3.rst

#3.- Equilibration steps (=pre-production)
$PMEMD -O -i eq1.in -o $1.eq1.out -p $1.prmtop -c $1.h.rst -r $1.eq1.rst -ref $1.h.rst
$PMEMD -O -i eq2.in -o $1.eq2.out -p $1.prmtop -c $1.eq1.rst -r $1.eq2.rst -ref $1.eq1.rst
$PMEMD -O -i eq3.in -o $1.eq3.out -p $1.prmtop -c $1.eq2.rst -r $1.eq3.rst -ref $1.eq2.rst
$PMEMD -O -i eq4.in -o $1.eq4.out -p $1.prmtop -c $1.eq3.rst -r $1.eq4.rst -ref $1.eq3.rst
$PMEMD -O -i eq5.in -o $1.eq5.out -p $1.prmtop -c $1.eq4.rst -r $1.eq5.rst -ref $1.eq4.rst
$PMEMD -O -i eq6.in -o $1.eq6.out -p $1.prmtop -c $1.eq5.rst -r $1.eq6.rst -ref $1.eq5.rst

rm -f $1.md0.rst
ln -s $1.eq6.rst $1.md0.rst

#4.- MD production
for i in `seq 1 1 1000`; do
echo $i
j=$((i-1))
$PMEMD -O -i md.in -o $1.md$i.out -p $1.prmtop -c $1.md$j.rst -r $1.md$i.rst -ref $1.md$j.rst
#bzip2 $1.md$j.rst $1.md$j.nc
done
##
