Getting and Cleaning Data - Course Project Code Book
============

This Code Book contains information about:

1.	Brief project description 
2.	The experimental study design used in this project
3.	The downloaded and loaded data
4.	The transformations or work that was performed to clean up the data
5.	The description of the tidy data variables


##Brief Project Description

This project is part of the Getting and Cleaning Data course from Johns Hopkins University through Coursera.
The goal is to write a computer script, in R, that takes the row data as input and outputs a tidy data file with the average of each variable for each activity and each subject. The row data was provided through the link below: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


##The experimental study design used in this project and the raw data

This project uses the experiments that have been carried out involved 30 volunteers performing six activities (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, researchers captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers were selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details.

The dataset includes the following files:
(In this file list I am just considering the files that were used in the script for the purpose of this project)

- activity_labels.txt - A two columns file matching the activity codes with its correspondent labels or descriptions.
 - 1 WALKING
 - 2 WALKING\_UPSTAIRS
 - 3 WALKING\_DOWNSTAIRS
 - 4 SITTING
 - 5 STANDING
 - 6 LAYING


- features.txt - This data set lists two types of variables:

  1. All of the features that comes from the accelerometer and gyroscope signals for each direction X,Y and Z, e.g. tBodyAcc-X tBodyAcc-Y, tBodyAcc-Z, tBodyGyro-X, tBodyGyro-Y and tBodyGyro-Z

  2. The set of variables that were estimated from these signals, for example, the mean (e.g., gravityMean, tBodyAccMean, tBodyAccJerkMean, tBodyGyroMean) and standard deviation (std()). Each row of this features data set corresponds to each column in the X\_Train/X\_Test files


- Train data sets – Includes three files concerning the training data generated by the subjects that performed the six activities:

 - subject_train.txt: includes the subjects ID that performed the activities. Each subject_train row parallels to each X\_train row.
 - X\_train.txt: includes train measurements

 - Y\_train.txt: includes the activity codes executed by each subject. Each Y\_train row parallels to each X\_test row.


- Test data sets – Includes three files concerning the test data generated by the subjects that performed the six activities:
 - subject_test.txt: includes the subjects ID that performed the activities. Each subject_test row parallels to each X\_test row.
 - X\_test.txt: includes test measurements
 - Y\_test.txt: includes the activity codes executed by each subject. Each Y\_test row parallels to each X\_test row.

The complete list of variables of each feature vector is available in 'features.txt' provided from the Dataset.zip file.


##Download and load the raw data
The raw data sets described in the previous section were downloaded from the Dataset.zip file and loaded directly into R.



##Transformations Performed

- The test data sets (subjectTest, Y\_test, X\_test) were merged by column using cbind function; The train sets (subjectTrain, Y\_train, X\_train) were merged by column using cbind function; and finally these two combinations were merged by row into a single data set using the rbind function.
This single data set contains 10299 different observations (rows) and 563 variables (columns). Below it’s an example of how this data set looks like:
```sh
 >mergedData[1:6,1:7] 
  V1 V1.1      V1.2          V2          V3         V4         V5         
1  2    5 0.2571778 -0.02328523 -0.01465376 -0.9384040 -0.9200908
2  2    5 0.2860267 -0.01316336 -0.11908252 -0.9754147 -0.9674579
3  2    5 0.2754848 -0.02605042 -0.11815167 -0.9938190 -0.9699255
4  2    5 0.2702982 -0.03261387 -0.11752018 -0.9947428 -0.9732676
5  2    5 0.2748330 -0.02784779 -0.12952716 -0.9938525 -0.9674455
6  2    5 0.2792199 -0.01862040 -0.11390197 -0.9944552 -0.9704169
```
- It was extracted only the measurements variables on the mean and standard deviation for each measurement, thus the merged data frame was reloaded to contain only the non-measurement columns (Subject, Activity) and this mean and standard deviation measurements variables.

- The Activity column names were transformed from the activity code into the correspondent activity_labels: 
(1 WALKING, 2 WALKING\_UPSTAIRS, 3 WALKING\_DOWNSTAIRS, 4 SITTING, 5 STANDING, 6 LAYING).

- The variables names that represent the subjects and the activities, as well as the measurement variable names were transformed into descriptive variable names(e.g.,V1 into Subject, V1.1 into Activities, V2 into tBodyAcc-mean()-X).

At this point the data set contains 10299 different observations (rows), 68 variables (columns) and looks like this:
```sh
> mergedData[1:6,1:5]
 Subject Activity tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z
1      2   STANDING       0.2571778       -0.02328523       -0.01465376
2      2   STANDING       0.2860267       -0.01316336       -0.11908252
3      2   STANDING       0.2754848       -0.02605042       -0.11815167
4      2   STANDING       0.2702982       -0.03261387       -0.11752018
5      2   STANDING       0.2748330       -0.02784779	    -0.12952716
6      2   STANDING       0.2792199       -0.01862040       -0.11390197
```
- It was created a second, independent tidy data frame with the calculated average of each variable for each activity and each subject.
This data frame name is tidy\_data, contains 180 rows (30 subjects x 6 activities), 68 variables (first variable contains the Subject, second variable contains the Activities, and the  other 66 variables contains the average of each measurable variable for each activity and each subject. The data set looks like this:
```sh
 >tidy_data[1:6,1:4]

  Subject              Activity     tBodyAcc-mean()-X  tBodyAcc-mean()-Y
1       1 	            WALKING             0.2773308       -0.017383819
2       1      WALKING_UPSTAIRS             0.2554617       -0.023953149
3       1    WALKING_DOWNSTAIRS             0.2891883       -0.009918505
4       1               SITTING             0.2612376       -0.001308288
5       1              STANDING             0.2789176       -0.016137590
6       1                LAYING             0.2215982       -0.040513953
```
- The result loaded into the tidy\_data data frame is saved as tidy_data.txt data set file, in order to be uploaded into coursera.

##The Processed data - tidy data 

The tidy data set name is tidy\_data.txt, it contains 180 rows and 68 columns.
Besides columns Subject and Activity, this file also contains the variables that are the average of each measurement variable contained in the mergedData data frame for each activity and each subject.
 
The set of variables contained in this file are:
```
 Subject    : integer  1 through 30

 Activity   : Factor w/ 6 levels "WALKING", "WALKING\_UPSTAIRS", "WALKING\_DOWNSTAIRS", "SITTING", "STANDING", "LAYING" 
 
 Variables that contains the average of each measurement variable for each activity and each subject:

 tBodyAcc-mean()-X           : numeric  0.277 0.255 0.289 0.261 0.279 ...

 tBodyAcc-mean()-Y           : numeric  -0.01738 -0.02395 -0.00992 -0.00131 -0.01614 ...

 tBodyAcc-mean()-Z           : numeric  -0.1111 -0.0973 -0.1076 -0.1045 -0.1106 ...

 tBodyAcc-std()-X            : numeric  -0.284 -0.355 0.03 -0.977 -0.996 ...

 tBodyAcc-std()-Y            : numeric  0.11446 -0.00232 -0.03194 -0.92262 -0.97319 ...

 tBodyAcc-std()-Z            : numeric  -0.26 -0.0195 -0.2304 -0.9396 -0.9798 ...

 tGravityAcc-mean()-X        : numeric  0.935 0.893 0.932 0.832 0.943 ...

 tGravityAcc-mean()-Y        : numeric  -0.282 -0.362 -0.267 0.204 -0.273 ...

 tGravityAcc-mean()-Z        : numeric  -0.0681 -0.0754 -0.0621 0.332 0.0135 ...

 tGravityAcc-std()-X         : numeric  -0.977 -0.956 -0.951 -0.968 -0.994 ...

 tGravityAcc-std()-Y         : numeric  -0.971 -0.953 -0.937 -0.936 -0.981 ...

 tGravityAcc-std()-Z         : numeric  -0.948 -0.912 -0.896 -0.949 -0.976 ...

 tBodyAccJerk-mean()-X       : numeric  0.074 0.1014 0.0542 0.0775 0.0754 ...

 tBodyAccJerk-mean()-Y       : numeric  0.028272 0.019486 0.02965 -0.000619 0.007976 ...

 tBodyAccJerk-mean()-Z       : numeric  -0.00417 -0.04556 -0.01097 -0.00337 -0.00369 ...

 tBodyAccJerk-std()-X        : numeric  -0.1136 -0.4468 -0.0123 -0.9864 -0.9946 ...

 tBodyAccJerk-std()-Y        : numeric  0.067 -0.378 -0.102 -0.981 -0.986 ...

 tBodyAccJerk-std()-Z        : numeric  -0.503 -0.707 -0.346 -0.988 -0.992 ...

 tBodyGyro.mean()-X          : numeric  -0.0418 0.0505 -0.0351 -0.0454 -0.024 ...

 tBodyGyro-mean()-Y          : numeric  -0.0695 -0.1662 -0.0909 -0.0919 -0.0594 ...

 tBodyGyro-mean()-Z          : numeric  0.0849 0.0584 0.0901 0.0629 0.0748 ...

 tBodyGyro-std()-X           : numeric  -0.474 -0.545 -0.458 -0.977 -0.987 ...

 tBodyGyro-std()-Y           : numeric  -0.05461 0.00411 -0.12635 -0.96647 -0.98773 ...

 tBodyGyro-std()-Z           : numeric  -0.344 -0.507 -0.125 -0.941 -0.981 ...

 tBodyGyroJerk-mean()-X      : numeric  -0.09 -0.1222 -0.074 -0.0937 -0.0996 ...

 tBodyGyroJerk-mean()-Y      : numeric  -0.0398 -0.0421 -0.044 -0.0402 -0.0441 ...

 tBodyGyroJerk-mean()-Z      : numeric  -0.0461 -0.0407 -0.027 -0.0467 -0.049 ...

 tBodyGyroJerk-std()-X       : numeric  -0.207 -0.615 -0.487 -0.992 -0.993 ...

 tBodyGyroJerk-std()-Y       : numeric  -0.304 -0.602 -0.239 -0.99 -0.995 ...

 tBodyGyroJerk-std()-Z       : numeric  -0.404 -0.606 -0.269 -0.988 -0.992 ...

 tBodyAccMag-mean()          : numeric  -0.137 -0.1299 0.0272 -0.9485 -0.9843 ...

 tBodyAccMag-std()           : numeric  -0.2197 -0.325 0.0199 -0.9271 -0.9819 ...

 tGravityAccMag-mean()       : numeric  -0.137 -0.1299 0.0272 -0.9485 -0.9843 ...

 tGravityAccMag-std()        : numeric  -0.2197 -0.325 0.0199 -0.9271 -0.9819 ...

 tBodyAccJerkMag-mean()      : numeric  -0.1414 -0.4665 -0.0894 -0.9874 -0.9924 ...

 tBodyAccJerkMag-std()       : numeric  -0.0745 -0.479 -0.0258 -0.9841 -0.9931 ...

 tBodyGyroMag-mean()         : numeric  -0.161 -0.1267 -0.0757 -0.9309 -0.9765 ...

 tBodyGyroMag-std()          : numeric  -0.187 -0.149 -0.226 -0.935 -0.979 ...

 tBodyGyroJerkMag-mean()     : numeric  -0.299 -0.595 -0.295 -0.992 -0.995 ...

 tBodyGyroJerkMag-std()      : numeric  -0.325 -0.649 -0.307 -0.988 -0.995 ...

 fBodyAcc-mean()-X           : numeric  -0.2028 -0.4043 0.0382 -0.9796 -0.9952 ...

 fBodyAcc-mean()-Y           : numeric  0.08971 -0.19098 0.00155 -0.94408 -0.97707 ...

 fBodyAcc-mean()-Z           : numeric  -0.332 -0.433 -0.226 -0.959 -0.985 ...

 fBodyAcc-std()-X            : numeric  -0.3191 -0.3374 0.0243 -0.9764 -0.996 ...

 fBodyAcc-std()-Y            : numeric  0.056 0.0218 -0.113 -0.9173 -0.9723 ...

 fBodyAcc-std()-Z            : numeric  -0.28 0.086 -0.298 -0.934 -0.978 ...

 fBodyAccJerk-mean()-X       : numeric  -0.1705 -0.4799 -0.0277 -0.9866 -0.9946 ...

 fBodyAccJerk-mean()-Y       : numeric  -0.0352 -0.4134 -0.1287 -0.9816 -0.9854 ...

 fBodyAccJerk-mean()-Z       : numeric  -0.469 -0.685 -0.288 -0.986 -0.991 ...

 fBodyAccJerk-std()-X        : numeric  -0.1336 -0.4619 -0.0863 -0.9875 -0.9951 ...
 
 fBodyAccJerk-std()-Y        : numeric  0.107 -0.382 -0.135 -0.983 -0.987 ...

 fBodyAccJerk-std()-Z        : numeric  -0.535 -0.726 -0.402 -0.988 -0.992 ...

 fBodyGyro-mean()-X          : numeric  -0.339 -0.493 -0.352 -0.976 -0.986 ...

 fBodyGyro-mean()-Y          : numeric  -0.1031 -0.3195 -0.0557 -0.9758 -0.989 ...

 fBodyGyro-mean()-Z          : numeric  -0.2559 -0.4536 -0.0319 -0.9513 -0.9808 ...

 fBodyGyro-std()-X           : numeric  -0.517 -0.566 -0.495 -0.978 -0.987 ...

 fBodyGyro-std()-Y           : numeric  -0.0335 0.1515 -0.1814 -0.9623 -0.9871 ...

 fBodyGyro-std()-Z           : numeric  -0.437 -0.572 -0.238 -0.944 -0.982 ...

 fBodyAccMag-mean()          : numeric  -0.1286 -0.3524 0.0966 -0.9478 -0.9854 ...

 fBodyAccMag-std()           : numeric  -0.398 -0.416 -0.187 -0.928 -0.982 ...

 fBodyBodyAccJerkMag-mean()  : numeric  -0.0571 -0.4427 0.0262 -0.9853 -0.9925 ...

 fBodyBodyAccJerkMag-std()   : numeric  -0.103 -0.533 -0.104 -0.982 -0.993 ...

 fBodyBodyGyroMag-mean()     : numeric  -0.199 -0.326 -0.186 -0.958 -0.985 ...

 fBodyBodyGyroMag-std()      : numeric  -0.321 -0.183 -0.398 -0.932 -0.978 ...

 fBodyBodyGyroJerkMag-mean() : numeric  -0.319 -0.635 -0.282 -0.99 -0.995 ...

 fBodyBodyGyroJerkMag-std()  : numeric  -0.382 -0.694 -0.392 -0.987 -0.995 ...
```
