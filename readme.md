---
title: "Getting and Cleaning Data Course Project"
author: "Demetris Papadopoulos"
date: "Sunday, March 22, 2015"
output: html_document
---

This is the repository created by Demetris Papadopoulos to serve the purposes of hosting the course project for the "Getting and Cleaning Data" course.

This directory contains the following: 

1) A folder named "Dataset" in which all the files of UCI HAR Dataset folder have been placed.

2) run_analysis.R file which if sourced would produce the dataset.txt

3) dataset.txt which is the product of sourcing the run_analysis.R file and which should be read into R using the read.table() command.

4) This readme.md file containing info about the other files and folders.

5) The CodeBook.md file which contains information about the variables.


The whole process could be recreated by cloning this repository on your own hard disk, setting the R working directory to the cloned folder and sourcing "run_analysis.R". This will re-produce the dataset.txt file as required by the needs of this project. As mentione above, the dataset.txt file can be read into R using the read.table() command.

Below I analyze the process of how the "run_analysis.R" file cleans the data:

Reading the training and the test sets, labels and subjects and binding them together as single data frames using rbind. We end up with 3 different data frames for subjects (dataframe s), labels(dataframe y) and sets(dataframe x).
The test sets are: Dataset/test/X_test.txt . The training sets are: Dataset/train/X_train.txt .
The test subjects are: Dataset/test/subject_test.txt. The training subjects are: Dataset/train/subject_train.txt
The test labels are: Dataset/test/y_test.txt. The training labels are: Dataset/train/y_train.txt

It then reads Dataset/features.txt and uses the grep command to select only those involving either mean or standard deviation. It then uses that shortened dataframe to select only the appropriate columns for our measurement set dataframe and using the gsub() and tolower() commands their names are decapitalized and the parentheses are removed.

The activity labels are being read and processed with the help of gsub and tolower commands. Then the label dataframe is processed using our previous work and the names of the column of the labels are  set as "activity".

Then it uses the names function to name as "subject" the column of dataframe and creates a new dataframe, merging the three dataframes created and processed earlier (sets of measurements, subjects and labels) using cbind().

Finally, a new data set is created for which the average of each variable for each activity and for each subject is calculated in a for loop and finally placed in the new dataframe which gets exported as a text file with the help of write.table() command.


