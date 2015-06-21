# coursera-getting-and-cleaning-data
Course Project for Getting and Cleaning Data course from Coursera

Included here are:

_run_analysis.R_ - script which downloads and transforms the Human Activity Recognition Using Smartphones Dataset from UCI (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#) and outputs a delimited text file "UCI_HAR_Averages.txt".

The script does the following:
  - Downloads and unzips source data files
  - Merges the training and the test sets to create one data set.
  - Appropriately labels the data set with descriptive variable names. 
  - Extracts only the measurements on the mean and standard deviation for each measurement. 
  - Uses descriptive activity names to name the activities in the data set
  - From the data set in previous steps, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  - Writes the resulting data set to UCI_HAR_Averages.txt

_codebook.md_ - file describing the data and variable for the dataset which results from running run_analysis.R
