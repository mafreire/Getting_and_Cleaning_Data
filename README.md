Getting and Cleaning Data - Course Project
===========

This repository contains files from my Course Project of Getting and Cleaning Data course that is part of the Data Science Johns Hopkins University Specialization through Coursera. These files are:

1. Readme.md  - That explains how my script works and how it can be reproduce
2. CodeBook.md - A Code Book that describes data, how the raw data files are connected, the needed transformations or work that I performed to clean up the data and each variable and its values in the tidy data set generated as output by the script 
3. run\_analysis.R - My analysis script

##The row data
This project is part of the Getting and Cleaning Data course from Johns Hopkins University through Coursera. It’s goal is to write a computer script, in R, that takes the row data as input and outputs a tidy data file.

The project is linked to an experiment that has been carried out that involved 30 volunteers performing six activities
(WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, researchers captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The data linked to from the course website represent data collected from these accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
[See full description](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

You can download the raw data here: 
[Raw data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)


##The Analysis script
The analysis script is called run\_analysis.R and what it does is it takes the row data as input and outputs a tidy data file with the average of each variable for each activity and each subject. This script uses the following row data files:

- subject\_test.txt
- X\_test.txt
- Y\_test.txt
- subject\_train.txt
- X\_train.txt
- Y\_train.txt
- features.txt
- activity\_labels.txt

A description of these row data files is provided in my CodeBook.md file placed in this repo.


####Explaining the script:
1. Loads the needed libraries and checks if the "data" directory exists, if it does not exist it is created
2. Downloads and unzip the raw data 
3. Loads into R the necessary raw data files
4. Merges the training and the test sets to create one data set called mergedData
5. Extracts from the mergedData data frame only the measurements on the mean and standard deviation for each measurement and updates this same mergedData data frame variable with the result of this extraction 
6. Set descriptive activity names to the activities in the mergedData data frame (it uses the activity\_labels data)
7. Appropriately labels the mergedData data frame with descriptive variable names 
8. From the data frame resulted in step 7, creates a second, independent tidy data set, named tidy\_data, with the average of each variable for each activity and each subject
9. The tidy\_data data frame resulted in the previous step is saved as tidy\_data.txt in order to be uploaded into coursera. This Tidy data set has 180 rows and 68 columns.


##Running the script - Instructions list
1. Step 1 - Clone this repo to your local machine
2. Step 2 - Open the RStudio and setup the correct working directory accordingly
3. Step 3 - Run the script: 

  1. install.packages("plyr"); install.packages("dplyr")
  1. source("run\_analysis.R")
  2. run\_analysis() 
 
4. Step 4 - Look for the tidy\_data.txt dataset file under the "./Getting_and_Cleaning_Data/data" folder. The description of this file is provided in my CodeBook.md file placed in this repo.

####Additional notes
This script was run in a Mac OS X machine, Version 10.6.8. 
It were made several tests always producing the same result (in all tests it was always obtained the same output file).
