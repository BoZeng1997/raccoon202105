#!/usr/bin/env python
#* This file is part of the RACCOON application
#* being developed at Dolbow lab at Duke University
#* http://dolbow.pratt.duke.edu

import os
import sys
import shutil
import math
import csv

num_samples = 10000

print("Writing list file...")
f = open("gold/list.txt", "w")
for k in range(90000,90000+num_samples):
    f.write("1D_PE_L10P100_Gc_E_r0_N50_cluster_set"+str(k).zfill(5)+"\n")
f.close()
