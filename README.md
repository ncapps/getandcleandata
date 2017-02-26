# Getting and Cleaning Data Course Project
The purpose of this Coursera project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. The R script, 'run_analysis.R', executes the following:

1. Download and unzip the Samsung Galaxy S smartphone accelermeter data if it does not exist.
2. Loads the training and test data sets.
3. Combines the data set, activity labels, and training subject labels by column for both training and test data sets.
4. Combines training and test data set objects by row.
5. Extracts only the measurements on the mean and standard deviation for each measurement.
6. Names the activities using the descriptive activity labels.
7. Names the measurement variables with the descriptive measurement feature.
8. Calculates average of each variable for each activity and each subject.

The end result is 'tidy_data.txt'.
