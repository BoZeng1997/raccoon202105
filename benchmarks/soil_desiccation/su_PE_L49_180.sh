#!/bin/bash
#SBATCH -N 1
#SBATCH --ntasks=8
#SBATCH --job-name=PE_L25_180
#SBATCH --partition=dolbowlab
#SBATCH --mem-per-cpu=10G
#SBATCH --mail-user=bo.zeng@duke.edu
#SBATCH --mail-type=END
#SBATCH -o JOBLOG%j

module load cmake/3.19.3-rhel8
module load Python/3.8.1
module load GCC/9.3.0
module load MPICH/3.2.1
export SLURM_CPU_BIND=none

for d in PE_L25P100_Gc_E_r0_N20_cluster_set18*; do
  cd $d
  echo "Start: $(date)"
  echo "cwd: $(pwd)"
  mpiexec /hpc/home/bz75/projects/raccoon/raccoon-opt -i GE_master.i
  echo "End: $(date)"
  mv $d.e /work/bz75/$d
  cd ..
done

