#Setting the work dir
setwd("C:/Users/jmlj/Coursera/DATASCIENCE")

#File download
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,destfile = "getdata-projectfiles-UCI HAR Dataset.zip")


### Checking and installing required packages
if (!require("plyr")) {
  install.packages("plyr")
  require("plyr")
}
if (!require("reshape2")) {
  install.packages("reshape2")
  require("reshape2")
}

#Tidying the files

# the "x" files are about the measurement
# the "y" files are about the activities

x_train <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
x_test <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
y_train <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
subject_train <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
activity_lables <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
features <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")

#1. Merges the training and the test sets to create one data set.
x_merged <- rbind(x_train,x_test)
head(x_merged,2)

#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
colnames(x_merged) <- c(as.character(features[,2])) #config the dataset column names
mean <- grep("mean()",colnames(x_merged),fixed=TRUE) #calculates the mean for each column
sd <- grep("std()",colnames(x_merged),fixed=TRUE) #calculates the sd for each column
mean_sd <-x_merged[,c(mean,sd)] #puts all together

#3. Uses descriptive activity names to name the activities in the data set
merged_y <- rbind(y_train,y_test)
activities <- cbind(merged_y,mean_sd) #combining the measures with the activities
colnames(activities)[1] <- "Activity"
head(activities,5) #just checking

#4. Appropriately labels the data set with descriptive variable names. 
activity_lables[,2] <- as.character(activity_lables[,2])

for(i in 1:length(activities[,1])){
  activities[i,1] <- activity_lables[activities[i,1],2]
}
head(activities,5) #just checking

#5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
merged_subjects <- rbind(subject_train,subject_test)
merged_data<-cbind(merged_subjects,activities)
colnames(merged_data)[1] <- "Subject"
tidy_data <- aggregate( merged_data[,3] ~ Subject+Activity, data = merged_data, FUN= "mean" )

for(i in 4:ncol(merged_data)){
  tidy_data[,i] <- aggregate( merged_data[,i] ~ Subject+Activity, data = merged_data, FUN= "mean" )[,3]
}

colnames(tidy_data)[3:ncol(tidy_data)] <- colnames(mean_sd)
write.table(tidy_data, file = "tidy_data_week3.txt")
