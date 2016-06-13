Getting and Cleaning Data Course Project

The run_analysis.R script takes data from the University of California at Irvine's Human Activity Recognition Using Smartphones (UCI HAR) dataset and creates a tidy dataset containg the average values for all of the mean and standard deviation variables calculated.

The UCI HAR project recorded data from the accelerometer and gyroscope embedded in Samsung Galaxy S II phones as the subjects of the experiment engaged in various activities. The subjects of the experiment were a group of 30 volunteers between the ages of 19 and 48, and the activities were: 
- walking
- walking upstairs
- walking downsatirs
- sitting
- standing 
- laying 

The data can be downloaded from here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones . I downloaded the data on 5/25/2016.

The data was randomly partitioned into two sets: a training set consisting of 70% of data collected from 70% of the subjects, and a test set consisting of the data collected from the remaining 30% of subjects. 

The unzipped "UCI HAR Dataset" data directory contains:
- activity-labels.txt   Each observation includes an activity variable, which will be a numeral from 1:6. This file is the key used to match the numerals to the six activities. 

- features_info.txt     This file contains the variable names assigned to the measurements

- README.txt            The original UCI README file describing the dataset.

- test dir              The measurements from the test set data

- train dir             The training set data.

The test dir contains:
-Inertial Signals dir
- subject_test.txt      This file, and the corresponding train data set file, identify the subject performing the activity during each observation.

- X_test.txt            This file, and the corresponding train data set file, contain the values measure during each observation for each variable. 

- Y_test.txt            This file, and the corresponding train data set file, contain the variable names for the values measure during each observation.

The run_analysis.R script assumes the working directory is the UCI HAR Dataset directory containing the files and directories described above. The script performs the following steps:

1. load the dplyr and reshape2 packages;

2. read in the data files, variable labels, subject ids, activity ids, and activity labels;

3. edit the features vector: select a list of variables that contain mean and standard deviation data and clean up the names of these variables by removing the parentheses and dashes;  

4. for both the test and train datasets, select the columns with the mean and standard deviation measurements, and add the activity and subject id labels to each observation.
5. row bind the test and train datasets into a single dataset;

6. convert the numeric activity ids into descriptive string labels (walking, standing, etc.);

7. group the dataset by subject and activity ids and calculate the means for each variable;

8. write the means as a tidy data set. 




The train dir contains:
- subject_train.txt
- X_train.txt
- Y_train.txt

