## This script assumes that the  working directory is the "UCI HAR Dataset" directory, 
## and that this dataset directory contains two subdirectories called
## "test" and "train".
library(dplyr)
library(reshape2)

test_path <- "./test/"
train_path <- "./train/"

## The "UCI HAR Dataset" directory contains two text files. The "activity_labels.t##xt"
## gives the labels for the different activities. 1: Walking, 2: Walking upstairs, ...
## The "features.txt" file contains the variable names for the data measurements. 

## Read in the labels for the data set:

features <- read.table("features.txt", sep = " ")
features <- as.character(features[,2])

## Read in the activity labels:

activity <- read.table("activity_labels.txt", sep = " ")
colnames(activity) <- c("factor", "label")
activity$label <- tolower(activity$label)

## To read in the subject id for each observation

subject_test <- read.table(paste(test_path,"subject_test.txt", sep = ""))
subject_train <- read.table(paste(train_path,"subject_train.txt", sep = ""))        
        
## Read in the activity label for each observation

activity_test <- read.table(paste(test_path,"y_test.txt", sep = ""))
activity_train <- read.table(paste(train_path,"y_train.txt", sep = "")) 


## Read the data. 
##there are two sets of files, training files and test files. The data needs to be 
## combined into a single dataset. The X_test.txt and X_train.txt files containt
## the feature vector measurements. 


if(!exists("test_data")){
        test_data <- read.table(paste(test_path, "X_test.txt", sep = "/"), col.names = features)
}
if(!exists("train_data")){
        train_data <- read.table(paste(train_path, "X_train.txt", sep = "/"), col.names = features)
}

## From the features text file, extract the names of the columns that contain 
## mean or standard deviation of the measurements and clean up the names.
featuresWanted <- grep("mean|std", features)

featuresClean <- features[grep("mean|std", features)]
featuresClean <- gsub("-mean", "Mean", featuresClean)
featuresClean <- gsub("-std", "Std", featuresClean)
featuresClean <- gsub("[()-]", "", featuresClean)
        
## Extract the columns that contain mean and std deviation of measurements from
## test_data and train_data. Then add the subject and activity information for
## each measurement.

test <- test_data[,featuresWanted]
test <- cbind(subject_test, activity_test, test)
colnames(test) <- c("subject", "activity", featuresClean)

train <- train_data[,featuresWanted]
train <- cbind(subject_train, activity_train, train)
colnames(train) <- c("subject", "activity", featuresClean)

data <- rbind(train, test)

## Convert the integers in the activity column to a factor and get the factor labels
## from the activity labels. 
data$activity <- as.factor(data$activity)
levels(data$activity) <- activity$label




melted <- melt(data, id = c("subject", "activity"))
meanData <- dcast(melted, subject + activity ~ variable, mean)

write.table(meanData, "tidyData.txt", row.names = FALSE, quote = FALSE)



