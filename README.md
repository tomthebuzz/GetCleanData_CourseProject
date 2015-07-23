# Getting & Cleaning Data 
## Course Project 1
### Explanation of "run_analysis.R" script

#### Preparatory Steps

Required libraries (data.table) and (dplyr) are loaded.

This section of the code prepares some base elements of the data intake by determining the classes of the 
variables in the X_ and Y_-Variables of the data files. It also reads the "features.txt" code book in order
to clean up the attribute names. Used three consecutive 'gsub()s' instead of piped operation for readability.
Finally the activity labels are also read as a last prep step.

#### Data Load from file

The next code section reads in the data files and combines them with the relevant column names, activtiy 
labels and subject IDs.  It also extracts only the relevant subset of measures (variables related to either
Mean or Standard Deviation (STD)) and combines this into a joint-up base data set.

#### Separate calculation of averages for MEAN and STD measures

This section of the code selects the relevant elements for the averaging of measures related to mean-Variables 
and STD-Variables by Subject and Activity. The results of these two calculatory steps are then joined up to
create the finalized tidy and wide data set.

This final set is then shown on the screen output. The final file creations are commented out and only to be used 
if and when required.

