#!/usr/bin/env python
#
# AccessDump.py
# A simple script to dump the contents of a Microsoft Access Database.
# It depends upon the mdbtools suite:
#   http://sourceforge.net/projects/mdbtools/

import sys, subprocess # the subprocess module is new in python v 2.4
import os

DATABASE = sys.argv[1]

# Get the list of table names with "mdb-tables"
table_names = subprocess.Popen(["mdb-tables", "-1", DATABASE], 
                               stdout=subprocess.PIPE).communicate()[0]
tables = table_names.split('\n')

# Dump each table as a CSV file using "mdb-export",
# converting " " in table names to "_" for the CSV filenames.
for table in tables:
    if not "P4S" in table:
        continue
    if table != '':
        filename = table.replace(" ","_") + ".csv"
        filename = filename.replace("P4S","P4S0")
        year = filename[1:3]
        if not os.path.exists(year):
            os.mkdir(year)
        filename = year+"/"+filename[0]+filename[3:]
        file = open(filename, 'w')
        print("Dumping " + table)
        contents = subprocess.Popen(["mdb-export", DATABASE, table],
                                    stdout=subprocess.PIPE).communicate()[0]
        file.write(contents)
        file.close()