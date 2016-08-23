# CodeBook

This is a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data.

The project analyzes the data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Download the data from the page https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Extract the to the current folder. The .\UCI HAR Dataset\ folder contains the "train" and "test" data for activity recognition study.

# The run_analysis.R program will do the following 

1. Merges the training and the test sets to create one data set. 
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
- For example, the column of "tBodyAcc-mean()-Y" will be kept, while the column of "tBodyAcc-mad()-Y" will be dropped.
3. Uses descriptive activity names to name the activities in the data set 
4. Labels the data set with descriptive variable names. 
5. Creates a independent tidy data set stored in the file "tidydata.txt", with the average of each variable for each activity and each subject.

