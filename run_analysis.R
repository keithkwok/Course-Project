setwd("C:/Users/Keith/Dropbox/keith sem2/post-sem2/JHU Data Science/Getting and CLeaning Data")
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile="./data/samsung.zip")

packages <- c("data.table", "reshape2")
sapply(packages, require, character.only=TRUE, quietly=TRUE)

SubjectTrain <- read.csv("./data/samsung/UCI HAR Dataset/train/subject_train.txt",sep="",header=FALSE)
SubjectTest <- read.csv("./data/samsung/UCI HAR Dataset/test/subject_test.txt",sep="",header=FALSE)

# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive activity names. 

colnames(SubjectTrain)  <- "subject"
colnames(SubjectTest)  <- "subject"

YTrain <- read.csv("./data/samsung/UCI HAR Dataset/train/y_train.txt",sep="",header=FALSE)
YTest <- read.csv("./data/samsung/UCI HAR Dataset/test/y_test.txt",sep="",header=FALSE)

XTrain <- read.csv("./data/samsung/UCI HAR Dataset/train/X_train.txt",sep="",header=FALSE)
XTest <- read.csv("./data/samsung/UCI HAR Dataset/test/X_test.txt",sep="",header=FALSE)

# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive activity names. 

colnames(YTest)  <- 'activity_labels'
colnames(YTrain)  <- 'activity_labels'

activity_labels  <- read.csv("./data/samsung/UCI HAR Dataset/activity_labels.txt",sep="",header=FALSE)
colnames(activity_labels)  <- c('activity_label','activity')

activityTest  <- merge(YTest, activity_labels)
activityTrain  <- merge(YTrain, activity_labels)

testData  <- cbind(XTest, activityTest)
trainData  <- cbind(XTrain, activityTrain)

Data <- rbind(testData, trainData)

features <- read.csv("./data/samsung/UCI HAR Dataset/features.txt", sep="", header=FALSE)
features <- features[,2]

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

Data  <- subset(Data,select = grepl("mean|std",features))

write.table(Data, file="tidyDataset.txt",sep='\t',row.names=FALSE)

# 1. Merges the training and the test sets to create one data set.

testData <- cbind(testData, subjectTest)
trainData <- cbind(trainData, subjectTrain)

Data1 <- rbind(testData, trainData)

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

tidyDataset2  <- aggregate( Data1[,1:562], Data1[,563:564], FUN = mean )

write.table(tidyDataset2, file="tidyDataset2.txt", sep="\t", row.names=FALSE)

