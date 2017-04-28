library(reshape2)

## Set some variables to work with the data set
fName <- "downloaded_data.zip"
extractDIR <- "UCI HAR Dataset"
downloadURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

## If the file is not here, then download it
if (!file.exists(fName)){
    download.file(downloadURL, fName, method="curl")
}  

## If the file hasn't been unzipped, do so
if (!file.exists(extractDIR)) { 
    unzip(fName) 
}

## Read activity labels
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])

## Read features
features <- read.table(paste(extractDIR, "/features.txt", sep=""))
features[,2] <- as.character(features[,2])

## Filter the data about mean (mean) and standard (std) deviation, first by filtering
## then by getting the names
wantedFeatures <- grep(".*mean.*|.*std.*", features[,2])
wantedFeatures.names <- features[wantedFeatures,2]

## Clean the variable names
wantedFeatures.names <- gsub('[-()]', '', wantedFeatures.names)
wantedFeatures.names = gsub('mean', '-Mean-', wantedFeatures.names)
wantedFeatures.names = gsub('std', '-Std-', wantedFeatures.names)


## Read the train datasats
train <- read.table(paste(extractDIR, "/train/X_train.txt", sep=""))[wantedFeatures]
trainActivities <- read.table(paste(extractDIR, "/train/Y_train.txt", sep=""))
trainSubjects <- read.table(paste(extractDIR, "/train/subject_train.txt", sep=""))
## Make a single structure
train <- cbind(trainSubjects, trainActivities, train)

## Read the test datasets
test <- read.table(paste(extractDIR, "/test/X_test.txt", sep=""))[wantedFeatures]
testActivities <- read.table(paste(extractDIR, "/test/Y_test.txt", sep=""))
testSubjects <- read.table(paste(extractDIR, "/test/subject_test.txt", sep=""))
test <- cbind(testSubjects, testActivities, test)

# Merge Train and Test
mergedData <- rbind(train, test)
colnames(mergedData) <- c("subject", "activity", featuresWanted.names)

# Make activities and subjects factors
mergedData$activity <- factor(mergedData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
mergedData$subject <- as.factor(mergedData$subject)

mergedData.melted <- melt(mergedData, id = c("subject", "activity"))
mergedData.mean <- dcast(mergedData.melted, subject + activity ~ variable, mean)

write.table(mergedData.mean, "tidyData.txt", row.names = FALSE, quote = FALSE)