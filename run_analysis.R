# create one R script called run_analysis.R that does the following.
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each 
#    measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.

library("data.table")

# read test data
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# read train data
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# merge test and train data
X <- rbind(X_train, X_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)

names(subject) <- "subject"
names(y) <- "activity"
featureNames <- read.table("./UCI HAR Dataset/features.txt")[,2]
names(X) <- featureNames

mergedData <- cbind(subject, y, X)

# Extracts only the measurements on the mean and standard deviation for each 
# measurement
selectedFeatureNames <- featureNames[grep("mean\\(\\)|std\\(\\)", featureNames)]
varNames <- c("subject", "activity", as.character(selectedFeatureNames))
selectedData <- subset(mergedData, select = varNames)

# Uses descriptive activity names to name the activities
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]
selectedData$activity <- activityLabels[selectedData$activity]

# Appropriately labels the data set with descriptive variable names.
names(selectedData)<-gsub("^t", "time", names(selectedData))
names(selectedData)<-gsub("^f", "frequency", names(selectedData))
names(selectedData)<-gsub("Acc", "Accelerometer", names(selectedData))
names(selectedData)<-gsub("Gyro", "Gyroscope", names(selectedData))
names(selectedData)<-gsub("Mag", "Magnitude", names(selectedData))
names(selectedData)<-gsub("BodyBody", "Body", names(selectedData))

# creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject.
library(plyr)
tidydata<-aggregate(. ~subject + activity, selectedData, mean)
write.table(tidydata, file = "tidydata.txt",row.name=FALSE)
