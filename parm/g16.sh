#!/bin/bash
#SBATCH --job-name=MOL
#SBATCH --partition=cpu
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=10GB

#name of the input file
input=MOL

export GAUSS_EXEDIR=/software/g16/g16/
export LD_LIBRARY_PATH=/software/g16/g16/:/software/g16/g16/bsd
export PATH=$PATH=/software/g16/g16/


#### RUN G16
/software/g16/g16/g16 ${input}.com > ${input}.log


