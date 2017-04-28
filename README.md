Getting and Cleaning Data: Data Project
=========================================

Introduction
------------
This is the final work for week 4 of the getting and cleaning data course

About the raw data
------------------

There are 561 features in the x_test.txt. 
There are activity labels in the y_test.txt file.
There are subjects in the subject_test.txt file.

The same pattern applies for the training set.

About the script and  output
-------------------------------------
There is a script called run_analysis.R which will merge the test and training sets together.
Prerequisites for this script:

1. The URL must be unchanged as it will fetch the data and download it
2. The Dataset must extract into a directory called "UCI HAR Dataset"

After merging de dataset, labels are added and only columns that contain mean and standard deviation are kept.

Lastly, the script will output a tidy file with the means of all the columns per test subject and per activity.
This tidy dataset will be tab-delimited written to tidyData.txt, which has been uploaded.

About the Code Book
-------------------
CodeBook.md file explains the transformations performed and the resulting data and variables.

