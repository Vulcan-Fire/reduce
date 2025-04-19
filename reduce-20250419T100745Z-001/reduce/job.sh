#!/bin/bash
#SBATCH -N 2
#SBATCH --ntasks-per-node=48
#SBATCH --error=job.%J.err
#SBATCH --output=job.%J.out
#SBATCH --time=00:10:00
#SBATCH --partition=standard

ulimit -s unlimited

echo `date`

for i in {8..80..8} 
do
  echo $i
  mpirun -n $i ./reduce 10240 
  mpirun -n $i ./reduce 1048576 
  mpirun -n $i ./reduce 8388608 
done

echo `date`

