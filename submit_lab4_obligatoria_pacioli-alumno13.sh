#!/bin/bash

#SBATCH -p hpc-bio-pacioli
#SBATCH --chdir=/home/alumno13/scripts_lab4/hpc-lab4
#SBATCH -J lab4-sergio
#SBATCH --output=slurm-%j.out
#SBATCG --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --mail-type=END
#SBATCH --mail-user="sergio.martihee1997@gmail.com"

# set the number of threads to the CPUs per task
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

$parallel "./file-cut.sh" :::{1:8}
