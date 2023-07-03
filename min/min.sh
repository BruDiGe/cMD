#!/bin/sh
#SBATCH --job-name=min_system
#SBATCH --partition=cpu
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=1
#SBATCH --mem=8GB
#SBATCH --gres=gpu:1

MOL=$1

source /software/amber20/amber.sh
export PMEMD=/software/amber20/bin/pmemd.cuda
export SANDER=/software/amber20/bin/sander.MPI
export AMBPDB=/software/amber20/bin/ambpdb
export PATH=/openmpi/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/openmpi/lib${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

export mpirun="/usr/local/openmpi/bin/mpirun -np 4"

export TMPDIR=/scratch/slurm_temp
export SLURM_TMPDIR=/scratch/slurm_temp
export SLURM_SUBMIT_DIR=$PWD


$mpirun $SANDER -O -i minTOT.in -o minTOT.out -p ../$1_vac.top -c ../$1_vac.crd -r $1_vac-min.rst

$AMBPDB -p ../$1_vac.top -c $1_vac-min.rst > $1_vac-min.pdb



