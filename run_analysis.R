## run_analysis.R
## Fulfills Course Project for Getting and Cleaning Data
## This script does the following:
##  - Downloads and unzips source data files
##  - Merges the training and the test sets to create one data set.
##  - Appropriately labels the data set with descriptive variable names. 
##  - Extracts only the measurements on the mean and standard deviation for each measurement. 
##  - Uses descriptive activity names to name the activities in the data set
##  - From the data set in previous steps, creates a second, independent tidy data set with the average 
##    of each variable for each activity and each subject.

library(reshape2)

##  - Downloads and unzip source data files
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "UCI_HAR_Dataset.zip")
unzippedFilepaths <- unzip("UCI_HAR_Dataset.zip")

##  - Merges the training and the test sets to create one data set.
# Read in test data
testFile <- unzippedFilepaths[grep("X_test.txt", unzippedFilepaths)]
testSubjFile <- unzippedFilepaths[grep("subject_test.txt", unzippedFilepaths)]
testActivityFile <- unzippedFilepaths[grep("/y_test.txt", unzippedFilepaths)]
testData <- read.table(testFile)
testData$Subject <- read.table(testSubjFile)[,1]
testData$Activity_ID <- read.table(testActivityFile)[,1]

# Read in training data
trainFile <- unzippedFilepaths[grep("X_train.txt", unzippedFilepaths)]
trainSubjFile <- unzippedFilepaths[grep("subject_train.txt", unzippedFilepaths)]
trainActivityFile <- unzippedFilepaths[grep("/y_train.txt", unzippedFilepaths)]
trainData <- read.table(trainFile)
trainData$Subject <- read.table(trainSubjFile)[,1]
trainData$Activity_ID <- read.table(trainActivityFile)[,1]

allData <- rbind(testData, trainData)

##  - Appropriately labels the data set with descriptive variable names.
featuresFile <- unzippedFilepaths[grep("features.txt", unzippedFilepaths)]
features <- read.table(featuresFile)
colnames(allData)[1:561] <- as.character(features[,2])

##  - Uses descriptive activity names to name the activities in the data set
ActivityLabelsFile <- unzippedFilepaths[grep("activity_labels.txt", unzippedFilepaths)]
activityLabels <- read.table(ActivityLabelsFile)
activities = character()
for (i in seq_along(allData$Activity_ID)) { 
        activities[i] <- as.character(activityLabels[allData[i, "Activity_ID"],2])
}
allData$Activity <- activities

##  - Extracts only the measurements on the mean and standard deviation for each measurement. 
mean_and_std <- allData[, grep("(mean|std)\\(\\)",colnames(allData))]
mean_and_std$Subject <- allData$Subject
mean_and_std$Activity <- allData$Activity

##  - From the data set in previous steps, creates a second, independent tidy data set with the average 
##    of each variable for each activity and each subject.
melted <- melt(mean_and_std, id=c("Activity", "Subject"), na.rm = TRUE)
measure_averages_by_activity_and_subject <- dcast(melted, Activity + Subject ~ variable, mean)

write.table(measure_averages_by_activity_and_subject, file = "UCI_HAR_Averages.txt", row.names = FALSE)
