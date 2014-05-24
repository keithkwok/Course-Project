setwd("C:/Users/Keith/Dropbox/keith sem2/post-sem2/JHU Data Science/Getting and CLeaning Data")
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile="./data/samsung.zip")

packages <- c("data.table", "reshape2")
sapply(packages, require, character.only=TRUE, quietly=TRUE)

dtSubjectTrain <- read.table("../data/samsung/UCI HAR Dataset/train/subject_train.txt")
dtSubjectTest <- read.table("../data/samsung/UCI HAR Dataset/test/subject_test.txt")

dtActivityTrain <- read.table("../data/samsung/UCI HAR Dataset/train/y_train.txt")
dtActivityTest <- read.table("../data/samsung/UCI HAR Dataset/test/y_test.txt")

dtTrain <- read.table("../data/samsung/UCI HAR Dataset/train/X_train.txt")
dtTest <- read.table("../data/samsung/UCI HAR Dataset/test/X_test.txt")

head(dtSubjectTrain)