#!/usr/bin/env python
#* This file is part of the RACCOON application
#* being developed at Dolbow lab at Duke University
#* http://dolbow.pratt.duke.edu

import os
import sys
import shutil
import math
import csv

if len(sys.argv) != 1:
    print("usage: ./generate_input.py")
    exit()

##################
###   listing  ###
##################

run_names = []
with open("gold/list.txt") as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=' ')
    for row in csv_reader:
        run_names.append(row[0])


with open('gold/GE_master.i', 'r') as input:
    master_input = input.read()
with open('gold/GE_fracture.i', 'r') as input:
    fracture_input = input.read()
with open('gold/GE_mechanical.i', 'r') as input:
    mechanical_input = input.read()
#with open('gold/refine.i', 'r') as input:
#    refine_input = input.read()
#with open('gold/batch.sh', 'r') as input:
 #   batch_file = input.read()
#with open('gold/quadint_out_data_dim10_ord3.csv', 'r') as csvfile:
 #   etaquad_file = csv.reader(csvfile, delimiter=',')
    # etaquad_file = csvfile.read()
  #  next(etaquad_file)
   # eta0 = []
    #for row in etaquad_file:
#        eta0.append(row)

count = 0

for run_name in run_names:
    count = count+1
#    print("---------------------------------------------")
    # print("Remove existing run folder: "+run_name)
    # try:
    #     shutil.rmtree(run_name)
    # except OSError as e:
    #     print ("     %s: %s." % (e.filename, e.strerror))

#    print("Create new run folder: "+run_name)

    # Create target Directory if don't exist
    if not os.path.exists(run_name):
        os.mkdir(run_name)
    else:
        print("     Directory "+run_name+" already exists")

    #mesh_file = "'fields_PE_L10P100_Gc_E_r0_N50_set000.e'"
    refined_mesh = "'../gold/fields_"+run_name+"'"
    # '../klexpansion/sample/fields_PSE_L3P100_Gc_E_r1_set00.e'
    fields_file = "'../gold/fields_"+run_name+".e'"
    out_file = "'"+run_name+"'"

    ##################
    ###   master   ###
    ##################

    #print("Writing master input file...")
    f = open(run_name+"/GE_master.i", "w")
    f.write(master_input % (fields_file,out_file))
    f.close()

    ##################
    ###  fracture  ###
    ##################

    #print("Writing fracture input file...")
    f = open(run_name+"/GE_fracture.i", "w")
    f.write(fracture_input % (fields_file))
    f.close()

    ##################
    ### mechanical ###
    ##################

    #print("Writing mechanical input file...")
    f = open(run_name+"/GE_mechanical.i", "w")
    f.write(mechanical_input % (fields_file))
    f.close()

    ##################
    ###   field    ###
    ##################

    #print("Writing mesh refinement file...")
    #f = open(run_name+"/refine.i", "w")
    #f.write(refine_input % (mesh_file,refined_mesh))
    #f.close()

    ##################
    ###   batch    ###
    ##################

#    print("Writing batch file...")
#    f = open(run_name+"/"+str(count)+".sh", "w")
#    f.write(batch_file % (run_name))
#    f.close()

    ##################
    ###   eta0     ###
    ##################

#    print("Writing eta0 file...")
#    # row1 = next(etaquad_file)
#    # print(row1)
#    f = open(run_name+"/eta0.csv", "w", newline='')
#    csvwriter = csv.writer(f,delimiter=',')
#    for j in range (len(eta0[count-1])):
#        csvwriter.writerow(eta0[count-1][j])
#        # print(j)
#        # print(eta0[count-1][j])
#    f.close()
