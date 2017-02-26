## Download and unzip the dataset:
filename <- "uci_har_dataset.zip"
if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
        download.file(fileURL, filename, mode ="wb")
}  
if (!file.exists("UCI HAR Dataset")) { 
        unzip(filename) 
}
## 1) Merges the training and the test sets to create one data set.
## Load training set and labels
## - 'train/X_train.txt': Training set.
trainingset <- read.table(".\\UCI HAR Dataset\\train\\X_train.txt")
## - 'train/y_train.txt': Training labels.
traininglabels <- read.table(".\\UCI HAR Dataset\\train\\y_train.txt")
## - 'subject_train.txt' : Each row identifies the subject who performed
trainingsubect <- read.table(".\\UCI HAR Dataset\\train\\subject_train.txt")

## - 'test/X_test.txt': Test set.
testset <- read.table(".\\UCI HAR Dataset\\test\\X_test.txt")
## - 'test/y_test.txt': Test labels.
testlabels <- read.table(".\\UCI HAR Dataset\\test\\y_test.txt")
## - 'subject_test.txt' : Each row identifies the subject who performed
testsubject <- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt")

##  Bind set, labels, and subject variables into 1 data set
trainingdata <- cbind(trainingset, traininglabels, trainingsubect)
testdata <- cbind(testset, testlabels, testsubject)

alldata <- rbind(trainingdata, testdata)
        
## 2) Extracts only the measurements on the mean and standard deviation for 
## each measurement.
## - 'features.txt': List of all features.
measurements <- read.table(".\\UCI HAR Dataset\\features.txt")
meanstdcols <- grep("mean()|std()",measurements[,2])
tidydata <- alldata[,c(meanstdcols,562, 563)]

## 3) Uses descriptive activity names to name the activities in the data set
## - 'activity_labels.txt': Links the class labels with their activity name.
activitylabels <- read.table(".\\UCI HAR Dataset\\activity_labels.txt")
tidydata[,80] <- sapply(tidydata[,80],function(x){activitylabels[x,2]})
        
## 4) Appropriately labels the data set with descriptive variable names.
measurementlabels <- measurements[meanstdcols,2]
names(tidydata) <- measurementlabels
names(tidydata)[80] <- "activity"; names(tidydata)[81] <- "trainingsubject"


## 5) From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.
library(dplyr)
avgtidydata <- 
        tidydata %>%
        group_by(activity, trainingsubject) %>%
        summarise_each(funs(mean))
write.table(avgtidydata, file=".\\tidy_data.txt", 
            row.names = FALSE)

                        
