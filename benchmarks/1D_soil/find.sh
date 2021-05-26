#!/bin/bash

for d in 1D_*set0*; do
  cd $d/
  #echo "$d_pearson.dat"
  if [ ! *timestep101.dat ]; #find $d -name $d_pearson.dat -print -quit | grep -q '^'; 
  then
    true
  else
    echo "the file does exist in $d"
    break
  fi
  cd ../
done
#*timestep101.dat
#set05606
#set06608
#set07605
#set08605
#set09079#
#set10023#
#set11025#
#set12023#
#set13024#
#set14024#
#set15023#
#set16023#
#set17025
#set18026
#set19027