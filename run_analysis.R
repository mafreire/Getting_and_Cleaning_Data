##1 - Loads the needed libraries and checks if the "data" directory exists if it does not exist it is created
##2 - downloads and unzips data measurements related to the experiments carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
##Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) 
##on the waist.
##3 - Load into R the necessary raw data files
##4 - Merges the training and the test sets to create one data set
##5 - Extracts only the measurements on the mean and standard deviation for each measurement 
##6 - Set descriptive activity names to the activities in the mergedData data frame
##7 - Appropriately labels the mergedData data frame with descriptive variable names
##8 - From the resulted mergedData data frame in step 7, creates a second, independent tidy data data frame with the average of each variable for each 
##activity and each subject
##9 - From the tidy_data data frame, created in step 8, saves a file as tidy_data.txt to be uploaded in coursera
run_analysis  <- function(){
        library(dplyr)
        library(plyr)
        library(dplyr)
        
        ## Check if the directory "data" exists if it does not exist it is created
        if(!file.exists("./data")){ 
                dir.create("./data")
        }
        
        ##download the raw data
        fileUrl  <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileUrl, destfile ="./data/Dataset.zip", method = "curl")
        
        ##unzip Dataset.zip file
        unzip ("./data/Dataset.zip", exdir = "./data")
        
        ##Merge the trainning and test datasets to create one data set
        #read the training and the test data sets
        subjectTest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", header = FALSE, stringsAsFactors = FALSE, strip.white = TRUE, fill = TRUE)
        X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", header = FALSE, stringsAsFactors = FALSE, strip.white = TRUE, fill = TRUE)
        Y_test <- read.table("./data/UCI HAR Dataset/test/Y_test.txt", header = FALSE, stringsAsFactors = FALSE, strip.white = TRUE, fill = TRUE)

        subjectTrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", header = FALSE, stringsAsFactors = FALSE, strip.white = TRUE, fill = TRUE)
        X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", header = FALSE, stringsAsFactors = FALSE, strip.white = TRUE, fill = TRUE)
        Y_train <- read.table("./data/UCI HAR Dataset/train/Y_train.txt", header = FALSE, stringsAsFactors = FALSE, strip.white = TRUE, fill = TRUE)
        
        #Read the features and activity_labels data sets
        features <- read.table("./data/UCI HAR Dataset/features.txt", header = FALSE, stringsAsFactors = FALSE, strip.white = TRUE, fill = TRUE)
        activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", header = FALSE, stringsAsFactors = FALSE, strip.white = TRUE, fill = TRUE)
        
        #Merge the trainning and test datasets into the data frame: mergedData 
        #mergedData <- cbind(rbind(subjectTest, subjectTrain), rbind(Y_test, Y_train), rbind(X_test, X_train))
        mergedData <- rbind(cbind(subjectTest, Y_test, X_test), cbind(subjectTrain, Y_train, X_train))
        
        ##Extract only the measurements on the mean and standard deviation for each measurement
        #1 - retrieve only the indexes of the columns corresponding to the mean and standard deviation
        #2 - sum 2 to each retrieved index to start pointing from column 3 on, excluding non measurement columns: Subject(column 1) and Activity (column 2)
        #3 - create subset containing non measurement columns and only the measurements columns on the mean and standard deviation for each measurement
        meanstdCols <- grep("mean\\(|std\\(", features[,2])
        meanstdCols <- sapply(meanstdCols,function (x) sum(x,2))
        mergedData  <- subset(mergedData, select=c(1,2,meanstdCols))
        
       
        #Set mergedData data frame with descriptive activity names using the activity_labels data frame 
        mergedData[,2]<- factor(mergedData[,2], levels = activity_labels[, 1], labels = activity_labels[, 2])
        
        #Set mergedData with descriptive variable names
        colnames(mergedData)[1:2] <- c("Subject", "Activity")
        colnames(mergedData)[3:length(mergedData)]  <- grep("mean\\(|std\\(", features[,2], value=TRUE)
        
        #Create a second, independent tidy data set with the average of each variable for each activity and each subject. 
        #ddply splits the mergedData data frame, apply the function to each piece and returns the result to the data frame tidy_data
        tidy_data <- ddply(mergedData,.(Subject, Activity),.fun=function(x) colMeans(x[ ,3:length(mergedData)]))
        
        #From the tidy_data data frame saves a file as tidy_data.txt to be uploaded in coursera
        write.table(tidy_data, file="./data/tidy_data.txt", row.names = FALSE)
}