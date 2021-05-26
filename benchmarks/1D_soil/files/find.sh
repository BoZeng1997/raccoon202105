#!/bin/bash

for d in 1D_*set11*; do
  cd $d/
  #echo "$d_pearson.dat"
  if [ -f *timestep*.dat ]; #find $d -name $d_pearson.dat -print -quit | grep -q '^'; 
  then
    true
  else
    echo "the file does not exist in $d"
    break
  fi
  cd ../
done

#set05606
#set06608
#set07605
#set08605
#
