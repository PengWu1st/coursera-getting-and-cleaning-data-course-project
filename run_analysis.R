#Step 0 Download and unzip file
library(dplyr)
library(tidyr)

destfile <- "Data.zip" 
if (!file.exists(destfile)){
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileUrl, destfile)
}
if (!file.exists("UCI HAR Dataset")) { 
        unzip(destfile)
}


#Step 1 Merges the training and the test sets to create one data set.
xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt") 
subjecttrain <- read.table("./UCI HAR Dataset/train/subject_train.txt") 
datatrain <- cbind(subjecttrain,ytrain,xtrain)

xtest <- read.table("UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("UCI HAR Dataset/test/y_test.txt")
subjecttest <- read.table("UCI HAR Dataset/test/subject_test.txt")
datatest <- cbind(subjecttest,ytest,xtest)

alldata <- rbind(datatrain,datatest)


#Step 2 Extracts only the measurements on the mean and standard deviation for each measurement.
features <- read.table("UCI HAR Dataset/features.txt")
disiredfeatures <- grep("mean()|std()" ,features[,2])
datawanted <- alldata[,c(1,2,disiredfeatures+2)]


#Step 3 Uses descriptive activity names to name the activities in the data set
activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt")
datawanted[,2] <- factor(datawanted[,2], levels = activitylabels[,1], labels = activitylabels[,2])


#Step 4 labels the data set with descriptive variable names.
featuresname <- features[,2][disiredfeatures]
featuresname <- gsub("[-()]","",featuresname)
featuresname <- gsub("mean","Mean",featuresname)
featuresname <- gsub("std","Std",featuresname)
colnames(datawanted) <- c("subject","activity",featuresname)


#Step 5 creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidydata <- 
        datawanted %>% 
        gather("measurement","value",-(1:2)) %>% 
        group_by(subject, activity, measurement) %>% 
        summarise(mean = mean(value)) %>%
        spread(measurement, mean)

write.table(tidydata,"tidydata.txt", row.names = FALSE, quote = FALSE)
