#!/bin/bash

cd /Users/bozeng/projects/raccoon/benchmarks/1D_soil/%s
#/Users/bozeng/projects/raccoon/benchmarks/klexpansion/sample/sample-opt
#mpiexec -n 4 /Users/bozeng/projects/raccoon/raccoon-opt -i refine.i
mpiexec -n 4 /Users/bozeng/projects/raccoon/raccoon-opt -i GE_master.i
cd ../
