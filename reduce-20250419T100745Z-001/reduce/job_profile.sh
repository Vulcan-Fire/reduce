#!/bin/bash
#SBATCH -N 2
#SBATCH --ntasks-per-node=48
#SBATCH --error=job.%J.err
#SBATCH --output=job.%J.out
#SBATCH --time=00:10:00
#SBATCH --partition=standard

ulimit -s unlimited

echo `date`

export LD_PRELOAD=../myprofiler/libprofile.so

for i in {8..80..8} 
do
  echo $i
  mpirun -n $i ./reduce 10240 
  mv log_reduce.txt log_N${i}_10K.txt
  mpirun -n $i ./reduce 1048576 
  mv log_reduce.txt log_N${i}_1M.txt
  mpirun -n $i ./reduce 8388608 
  mv log_reduce.txt log_N${i}_8M.txt
done

echo `date`

