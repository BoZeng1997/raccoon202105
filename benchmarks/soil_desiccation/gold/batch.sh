#!/bin/bash

cd /Users/bozeng/projects/raccoon/benchmarks/soil_desiccation/%s
#/Users/bozeng/projects/raccoon/benchmarks/klexpansion/sample/sample-opt
mpiexec -n 4 /Users/bozeng/projects/raccoon/raccoon-opt -i refine.i
mpiexec -n 4 /Users/bozeng/projects/raccoon/raccoon-opt -i GE_master.i
cd ../
