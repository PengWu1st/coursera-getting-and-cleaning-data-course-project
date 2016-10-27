#Course Project - Getting and Cleaning Data
___________________________________________
####Peng Wu
####wupeng1127@foxmail.com
__________________________
####This is the course project for the Getting and Cleaning Data course on Coursera.
____________________________________________________________________________________
####Here are what the R script run_analysis.R do:
_____________________________________________

1. Download and unzip file if the file does not exist
2. Load the train data set and test data set into R and merge them into one data set called 'alldata'
3. Extracts only the measurements on the mean and standard deviation for each measurement and store the result into 'datawanted'
4. Uses activity names in 'activity_labels.txt' to name the activities in the data set
5. Rename the variable in the data set.
6. Creates a tidy data set 'tidydata.txt' with the average of each variable for each activity and each subject.