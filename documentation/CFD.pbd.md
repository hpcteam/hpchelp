#!/bin/bash


#PBS -N su2
#PBS -l select=1:ncpus=2:mpiprocs=2
#PBS -l walltime=00:30:00
#PBS -o su2_output.o
#PBS -e su2_error.e
#PBS -q workq

# Move to the directory from which the job was submitted
cd $PBS_O_WORKDIR

# Load SU2 environment (adjust if your cluster uses modules)
export SU2_HOME=/opt/su2
export PATH=$SU2_HOME/bin:$PATH
export LD_LIBRARY_PATH=$SU2_HOME/lib:$LD_LIBRARY_PATH

# Run SU2 in parallel using the allocated processors
mpirun -np $PBS_NP SU2_CFD inv_channel.cfg

