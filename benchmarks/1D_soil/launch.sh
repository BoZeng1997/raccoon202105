#!/bin/bash
#for f in su_0{0,1,2,3,4}.sh;do
for f in su_0{5,6,7,8,9}.sh;do
  sbatch $f
done
