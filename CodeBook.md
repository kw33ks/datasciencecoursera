# CodeBook.md

##### +++++++++++++++++++++++++++++++++++++++++++++++++++
### UCI Samsung S2 Data Transformer v 1.0
##### +++++++++++++++++++++++++++++++++++++++++++++++++++


## Background 
#### This script modifies a set of data made available through UCI's Machine Learning Group. UCI's original data is recorded from a Galaxy S2 Smartphone using a group of 30 volunteers performing 6 activities: 

1. Walking
2. Walking Upstairs
3. Walking Downstairs
4. Sitting
5. Standing
6. Laying

Note: In the source data, the above is fragmented into two data sets: test (30% of volunteers) and training (70% of volunteers)

#### Additional methodology detail from UCI's original "README.txt" file:

"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details." 


#### For additional information on the original data set, you can download and unzip UCI's data to your working directory with the following R commands:

```{r}
download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","./S2_data")
unzip("./S2_data")
```



## Process

#### I transform UCI's data using the following steps (performed in run_analysis.R):

1. Download UCI's data set
2. Assemble **test** data set by combining "subject_test.txt", "X_test.txt", and "y_test.txt" into a single data frame 
3. Add an additonal column (#3) with description of the activity number in "y_test.txt" i.e. ("Walking")
4. Assemble **training** data set by combining "subject_train.txt", "X_train.txt", and "y_train.txt" into a single data frame 
5. Add an additonal column (#3) with description of the activity number in "y_train.txt" i.e. ("Walking")
6. Combine test and training data sets
7. Remove all variables (columns) that do not measure mean or std dev
8. Create a "tidy" data set that takes the average of each remaining variable for each activity and each volunteer

NOTE: Tidy data set values are _averages_ not actual recorded values

## Rationale

I chose to export in a .txt file format because it is extremely universal.

I chose to not include the following variables from UCI's original data set because they were not obtained the same way as the rest of the data:

* gravityMean
* tBodyAccMean
* tBodyAccJerkMean
* tBodyGyroMean
* tBodyGyroJerkMean

## Assumptions

I am assuming the UCI data to be as accurately recorded as possible, and that the experiementers minimized any type of external factors that could skew the smartphone readings. 

## Variable/Column Definitions (w/ units)

Descriptions of the original data set can be found in UCI's Dataset by using the downlaod command mentioned above.

#### Below are the descriptions of the final data set: 

* **"Volunteer_num"** (Integer) - Volunteer number (1-30)
* **"Activity_num"** (Integer) - Activity number (1-6)
* **"Activity_desc"** (Character) - Description of activity (i.e. "Walking"). This was created by copying the Activity_num column and replacing its values with the corresponding character description.
* **Variables beginning with "mean"** (Numeric) - Represent an average of each of UCI's variables. It is important to note that these UCI variables have no units, rather they are a ratio of a value divided by its range. The variable names denote what is being measured, and if it is in the X,Y, or Z plane.  




