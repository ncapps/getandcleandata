## 1) Merges the training and the test sets to create one data set.

## - 'train/subject_train.txt': Each row identifies the subject who performed 
##      the activity for each window sample. Its range is from 1 to 30. 

## Load training set and labels
## - 'train/X_train.txt': Training set.
trainingset <- read.table(".\\train\\X_train.txt")
## - 'train/y_train.txt': Training labels.
traininglabels <- read.table(".\\train\\y_train.txt")
## - 'subject_train.txt' : Each row identifies the subject who performed
trainingsubect <- read.table(".\\train\\subject_train.txt")

## - 'test/X_test.txt': Test set.
testset <- read.table(".\\test\\X_test.txt")
## - 'test/y_test.txt': Test labels.
testlabels <- read.table(".\\test\\y_test.txt")
## - 'subject_test.txt' : Each row identifies the subject who performed
testsubject <- read.table(".\\test\\subject_test.txt")

##  Bind set, labels, and subject variables into 1 data set
trainingdata <- cbind(trainingset, traininglabels, trainingsubect)
testdata <- cbind(testset, testlabels, testsubject)

alldata <- rbind(trainingdata, testdata)
        
## 2) Extracts only the measurements on the mean and standard deviation for 
## each measurement.
## - 'features.txt': List of all features.
measurements <- read.table(".\\features.txt")
meanstdcols <- grep("mean()|std()",measurements[,2])
tidydata <- alldata[,c(meanstdcols,562, 563)]

## 3) Uses descriptive activity names to name the activities in the data set
## - 'activity_labels.txt': Links the class labels with their activity name.
activitylabels <- read.table(".\\activity_labels.txt")
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
write.table(avgtidydata, file=".\\run_analysis.txt", 
            row.names = FALSE)

                        
