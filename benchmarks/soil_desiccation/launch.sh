#!/bin/bash

for f in su_PE_*.sh;do
  sbatch $f
done
