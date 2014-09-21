## Coursera getting and cleaning data project
## tidying test data

## step 1 merge test and training set

## Read test data (X_test, subject_test, and y_test )
testData <- read.table("./data/test/X_test.txt", stringsAsFactors = F, header = F)
testSubject <- read.table("./data/test/subject_test.txt", stringsAsFactors = F, header = F)
testLabel <- read.table("./data/test/y_test.txt", stringsAsFactors = F, header = F)

## Read training data(y_training, subject_training, and y_training)
trainData <- read.table("./data/train/X_train.txt", stringsAsFactors = F, header = F)
trainSubject <- read.table("./data/train/subject_train.txt", stringsAsFactors = F, header = F)
trainLabel <- read.table("./data/train/y_train.txt", stringsAsFactors = F, header = F)

## merge similar data first
allData <- rbind(trainData, testData) # 10299x561
allSubject <- rbind(trainSubject, testSubject) # 10299x1
allLabel <- rbind(trainLabel, testLabel) # 10299x1


## step 2 Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.table("./data/features.txt", stringsAsFactors = F, header = F)
## get mean() and std() column numbers
meanStdColNum <- grep("mean\\(\\)|std\\(\\)", features[,2])
allData <- allData[,meanStdColNum]

## rename column names for better reading
names(allData) <- gsub("mean\\(\\)", "Mean", names(allData)) # rename mean() to Mean
names(allData) <- gsub("BodyBody", "Body", names(allData)) # rename BodyBody to Body
names(allData) <- gsub("std\\(\\)", "STD", names(allData)) # rename std() to STD
names(allData) <- gsub("-", "", names(allData)) # remove - sign

## Step 3 Uses descriptive activity names to name the activities in the data set
activity <- read.table("./data/activity_labels.txt", stringsAsFactors = F, header = F)
activity[,2] <- c("walking", "walkingUpstairs", "walkingDownstairs", "sitting", "standing", "laying")
allLabel[,1] <- activity[allLabel[,1], 2]
names(allLabel) <- "activity"

## Step 4 Appropriately labels the data set with descriptive variable names. 
names(allSubject) <- "subject"
tidyData <- cbind(allSubject, allLabel, allData)

## remove unnessesary variabel data to clean memory
rm(activity)
rm(allData)
rm(allLabel)
rm(allSubject)
rm(testData)
rm(testSubject)
rm(testLabel)
rm(trainData)
rm(trainSubject)
rm(trainLabel)
rm(features)
rm(meanStdColNum)

## step 5 From the data set in step 4, creates a second, 
## independent tidy data set with the average of each variable for each activity and each subject.
tidyData$subject <- as.factor(tidyData$subject)
tidyData$activity <- as.factor(tidyData$activity)
tidyData2 <- aggregate(tidyData, by=list(activity = tidyData$activity, subject=tidyData$subject), mean)
## remove duplicated columns
tidyData2[,3] <- NULL
tidyData2[,3] <- NULL
write.table(tidyData2, "tidy_data.txt", row.names=F)