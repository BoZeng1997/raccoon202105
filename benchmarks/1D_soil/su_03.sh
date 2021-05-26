#!/bin/bash
#SBATCH -N 1
#SBATCH --ntasks=4
#SBATCH --job-name=1D_PEL10_93
#SBATCH --partition=dolbowlab
#SBATCH --mem-per-cpu=10G
#SBATCH --mail-user=bo.zeng@duke.edu
#SBATCH --mail-type=END
#SBATCH -o 1D_PEL10_93_%j

module load cmake/3.19.3-rhel8
module load Python/3.8.1
module load GCC/9.3.0
module load MPICH/3.2.1
export SLURM_CPU_BIND=none
cd files/
for d in 1D_PE_L10P100_Gc_E_r0_N50_cluster_set93*; do
  cd $d
  echo "Start: $(date)"
  echo "cwd: $(pwd)"
  mpiexec /hpc/home/bz75/projects/raccoon/raccoon-opt -i GE_master.i
  echo "End: $(date)"
  /hpc/home/bz75/projects/raccoon/benchmarks/klexpansion/parse/parse_result-opt 1D*.e
  mv $d.e /work/bz75/files/$d
  mv *.dat /work/bz75/files/$d
  cd ..
done
cd ../
mv 1D_PEL10_93_* /work/bz75/

