
#include <stdio.h>
#include <stdlib.h>
#include "mpi.h"

int main( int argc, char *argv[])
{
  int myrank, size;
  int count = atoi(argv[1]);
  double sendval[count], minval[count], maxval[count], sumval[count];
  MPI_Status status;

  struct {
   float val;
   int rank;
  } buf, recvbuf;

  MPI_Init (&argc, &argv);
  MPI_Comm_rank (MPI_COMM_WORLD, &myrank);
  MPI_Comm_size (MPI_COMM_WORLD, &size);

  double stime = MPI_Wtime();
  MPI_Reduce(sendval, minval, count, MPI_DOUBLE, MPI_MIN, 0, MPI_COMM_WORLD); // find min of sendvals
  MPI_Reduce(sendval, sumval, count, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD); // find sum of sendvals
  double etime = MPI_Wtime();
  if (!myrank) printf("%.4lf\n", etime - stime);

  MPI_Finalize();
  return 0;

}

