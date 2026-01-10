# SU2 PBS Job Script

This is a sample PBS script to run **SU2 CFD** in parallel on a cluster. It requests resources, loads the necessary modules, and runs SU2 using MPI.

```bash
#!/bin/bash
#PBS -N su2
#PBS -l select=1:ncpus=3:mpiprocs=3
#PBS -l walltime=00:30:00
#PBS -o su2_output.o
#PBS -e su2_error.e
#PBS -q workq

cd $PBS_O_WORKDIR

# Load SU2 environment
export SU2_HOME=/opt/su2
export PATH=$SU2_HOME/bin:$PATH
export LD_LIBRARY_PATH=$SU2_HOME/lib:$LD_LIBRARY_PATH

# Load MPI module (choose the one used to compile SU2)
module load OpenMpi/5.0.9

# Run SU2 in parallel on 3 MPI processes
mpirun -np 3 SU2_CFD /home/softwares/su2/su2code-SU2-d170b54/TestCases/incomp_euler/inv_nozzle.cfg

