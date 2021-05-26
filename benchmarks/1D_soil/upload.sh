#!/bin/bash

# for d in PE_L49P100_Gc_E_r0_N10_cluster_set08{0,1,2,3,4}; do
 #for d in PE_L25P100_Gc_E_r0_N20_cluster_set00*; do
  #scp $d/$d.e vcm@vcm-15221.vm.duke.edu:~/gary/FragCount/result/cluster/$d
  #sleep 30
  #scp $d/$d.e bozeng@localhost:~/projects/raccoon/benchmarks/soil_desiccation/cluster/$d
  #mv $d/$d.e /work/bz75/$d
#done
cd files/
for d in 1D_PE_L10P100_Gc_E_r0_N50_cluster_set2*; do
  mv $d/*.dat /work/bz75/files/$d
done
cd ../