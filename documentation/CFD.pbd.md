<<<<<<< HEAD
Here’s your script converted into a clean **Markdown (`.md`)** format. You can save this as something like `su2_job.md`.

````md
# SU2 PBS Job Script

=======
````markdown
# SU2 PBS Job Script

>>>>>>> 3488aac (push)
This document contains a PBS batch script for running **SU2** in parallel on an HPC system.

## PBS Directives

<<<<<<< HEAD
```
=======
```bash
>>>>>>> 3488aac (push)
#!/bin/bash
#PBS -N su2
#PBS -l select=1:ncpus=3:mpiprocs=3
#PBS -l walltime=00:30:00
#PBS -o su2_output.o
#PBS -e su2_error.e
#PBS -q workq
````

## Change to Working Directory

<<<<<<< HEAD
```
=======
```bash
>>>>>>> 3488aac (push)
cd $PBS_O_WORKDIR
```

## Load SU2 Environment

<<<<<<< HEAD
```
=======
```bash
>>>>>>> 3488aac (push)
export SU2_HOME=/opt/su2
export PATH=$SU2_HOME/bin:$PATH
export LD_LIBRARY_PATH=$SU2_HOME/lib:$LD_LIBRARY_PATH
```
<<<<<<< HEAD

## Load Required Modules

```
module load Mpich/5.0.0.1b
module load OpenMpi/5.0.9
```

## Run SU2 in Parallel

```
mpirun -np 1 SU2_CFD /home/softwares/su2/su2code-SU2-d170b54/TestCases/incomp_euler/inv_nozzle.cfg
```

```

=======

## Load Required Modules

```bash
module load Mpich/5.0.0.1b
module load OpenMpi/5.0.9
```

## Run SU2 in Parallel

```bash
mpirun -np 1 SU2_CFD /home/softwares/su2/su2code-SU2-d170b54/TestCases/incomp_euler/inv_nozzle.cfg
```

```

You can just **copy all of this** and save it as a `.md` file.  

If you want, I can also make a **version that includes comments and explanations inline** so anyone reading the Markdown understands what each line does. Do you want me to do that?
```
>>>>>>> 3488aac (push)

