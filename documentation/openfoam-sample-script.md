---
title: 📜 Openfoam-sample-script
parent: Documentation
---

# 📜 Openfoam-sample-script

#!/bin/bash 
#PBS -N interFoam_32 
#PBS -q workq 
#PBS -lselect=1:ncpus=32:mpiprocs=32:mem=192gb 
#PBS -l walltime=144:00:00 
#PBS -j oe 
#PBS -o openfoam.out 
#PBS -e openfoam.err

cd "$PBS_O_WORKDIR"

module purge

module use /home/softwares/modulefiles

module load ucx/1.12.0 OpenMPI/4.1.2-ucx-1.12.0 llvm/11.1.0

source /home/softwares/OpenFOAM-v2112_build/OpenFOAM-v2112/etc/bashrc

echo "===== ENV CHECK =====" 
which mpirun 
which icoFoam 
ldd $(whichmpirun) | grep ucx 
ldd $(which icoFoam) | grep mpi echo
"====================="

# Run OpenFOAM mesh generation

#rm -rf processor\*

#checkMesh

#blockMesh > blockMesh.log

#decomposePar -verbose -latestTime > decomposePar.log 2>&1

mpirun -np 32 interFoam -parallel > interFoam.log 2>&1
