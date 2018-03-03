Iran household income data
==========================

The rar files (not included here)
---------------------------------

The rar files can be downloaded from here:

https://www.amar.org.ir/دادهها-و-اطلاعات-آماری/هزینه-و-درامد-خانوار/هزینه-و-درامد-کل-کشور#103181018---

Each rar file contains the full data for a year. The data in the rar files come in mdb (Microsoft Access) format. Each mdb file contains more than 40 tables. The tables cover detailed data about sources of income, different expenditures, size of families, address, etc.

dumper.py
---------

It is a short python code that reads an mdb file (the rar files contain the data in mdb format) and extracts each table in the mdb file and dumps it as a separate csv file. In its current form, it only extracts the tables that have information about income in them (tables with "P4S" in their name), but this can easily be changed.

The year folders (80, 81, etc.)
-------------------------------

The code in dumper.py has been used to generate the folders that have years as their titles. Each folder contains the tables that are related to income. The csv files that start with U are for urban areas. The files starting with R (which I did not use in my calculations) are for rural areas.

theCode.R
---------

Reads the files in the year folders and creates a full table with all the information for the percentiles for each year in it. The result table is called "results".
Note that these results only cover urban areas.

finalResults.csv
----------------

After running theCode.R, I printed the content of "results" and pasted it in this file. Afterwards, I added to important columns to this file: price_index and adjusted_income. The price indexes are taken from "bank e markazi"'s website. I calculated the adjusted income for each percentile in each year based on the price index of that year.

forVisualization.R
------------------

This code is run on the augmented version of finalResults.csv (the version with adjusted incomes), and creates a plot like the one in Rplot.pdf.








