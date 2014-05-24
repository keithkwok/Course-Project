#setwd("C:/Users/Keith/Dropbox/keith sem2/post-sem2/JHU Data Science/Getting and CLeaning Data")
#url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#download.file(url, destfile="./data/samsung.zip")

packages <- c("data.table", "reshape2")
sapply(packages, require, character.only=TRUE, quietly=TRUE)

dtSubjectTrain <- read.table("./data/samsung/UCI HAR Dataset/train/subject_train.txt")
dtSubjectTest <- read.table("./data/samsung/UCI HAR Dataset/test/subject_test.txt")

dtYTrain <- read.table("./data/samsung/UCI HAR Dataset/train/y_train.txt")
dtYTest <- read.table("./data/samsung/UCI HAR Dataset/test/y_test.txt")

dtXTrain <- data.table(read.table("./data/samsung/UCI HAR Dataset/train/X_train.txt"))
dtXTest <- data.table(read.table("./data/samsung/UCI HAR Dataset/test/X_test.txt"))

#join the x files

dtX <- rbind(dtXTrain, dtXTest)

#join the y files

dtY <- rbind(dtYTrain, dtYTest)
setnames(dtY, "V1", "activityNum")

#join the subject files

dtSubject <- rbind(dtSubjectTrain, dtSubjectTest)
setnames(dtSubject, "V1", "subject")

#cbind all 3 cols, subject + x + y

dtSubject <- cbind(dtSubject, dtX)
dt <- cbind(dtSubject, dtY)

data.table(dt)
setkey(dt, subject, activityNum)

dtFeatures <- read.table("./data/samsung/UCI HAR Dataset/features.txt")

setnames(dtFeatures, names(dtFeatures), c("featureNum", "featureName"))

dtFeatures <- dtFeatures[grepl("mean\\(\\)|std\\(\\)", featureName)]

dtFeatures$featureCode <- dtFeatures[, paste0("V", featureNum)]
head(dtFeatures)

dtFeatures$featureCode

select <- c(key(dt), dtFeatures$featureCode)
dt <- dt[, select, with = FALSE]

dtActivityLabels <- read.table("./data/samsung/UCI HAR Dataset/activity_labels.txt")
setnames(dtActivityNames, names(dtActivityNames), c("activityNum", "activityName"))