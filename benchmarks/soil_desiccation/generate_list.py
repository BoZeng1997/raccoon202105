#!/usr/bin/env python
#* This file is part of the RACCOON application
#* being developed at Dolbow lab at Duke University
#* http://dolbow.pratt.duke.edu

import os
import sys
import shutil
import math
import csv

num_samples = 200

print("Writing list file...")
f = open("gold/list.txt", "w")
for k in range(num_samples):
    f.write("PE_L25P100_Gc_E_r0_N20_cluster_set"+str(k).zfill(3)+"\n")
f.close()
