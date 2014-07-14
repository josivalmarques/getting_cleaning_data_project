CodeBook for run_analysis.R
============================

The run_analysis.R script do the following:

1. It loads the zipped data files from the link https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  with the name "getdata-projectfiles-UCI HAR Dataset.zip" and checks and install the required packages

2. Then, it reads txt files with the train and test data

3. It continues doing the 5 steps required for the assignment:
 - Merges the training and the test sets to create one data set;
 - Extracts only the measurements on the mean and standard deviation for each measurement;
 - Uses descriptive activity names to name the activities in the data set;
 - Appropriately labels the data set with descriptive variable names;
 - Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

4. Then, it outputs a txt file with the tyde dataset, named as assignment_data.txt
