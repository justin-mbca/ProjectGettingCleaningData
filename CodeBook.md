#3) a code book that describes the variables, the data, and any transformations or work that you performed to clean #up the data called CodeBook.md.


Description of data set

This data set is downloadable from the link https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
A full description of the data is at the link http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The data are measurement of human motion signals, which are used to recognize human activity by machine learning. The data are recorded
signals of 30 persons carrying smartphone with signal sensors. Each person performed six activities including walking, walking upstairs, 
walking downstairs, sitting, standing and laying. With the sensors of accelerometer and gyroscope, signals of 3-axial linear acceleration 
and angular velocity were obtained at a constant rate of 50Hz. The acceleration signal was separated into gravitational and body motion components using a Butterworth low-pass filter. 

Description of Variables 

t(beginning with some variables) - time domain signals (captured at a constant rate of 50 Hz
tBodyAcc - body accelaration
tGravityAcc - gravity acceleration (acceleration caused by force of gravitation)
X,Y,Z - x,y,z direction
tBodyGyro - body angular velocity

Gerk - The time derivative of acceleration
tBodyAccJerk - time derivative of body acceleration
tBodyGyroJerk - time derivative of body angular velocity

Mag - magnitude of three dimensions calculated using the Euclidean norm, including tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag. For example tBodyAccMag is the magnitude of body acceleration by Euclidean norm.

f(beginning with some variables) - frequency domain signals by Fast Fourier Transformation to some time domain signals
fBodyAcc_XYZ
fBodyAccJerk_XYZ
fBodyGyro_XYZ
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

bandsEnergy: Energy of a frequency interval within the 64 bins of the FFT of each window.
fBodyAccJerk_bandsEnergy
fBodyGyro_bandsEnergy

list of variables on the mean and standard deviation

mean - object of mean of each variable: on each subject and each activity

 [1] "mean"                          "tBodyAcc_mean_X"               "tBodyAcc_mean_Y"              
 [4] "tBodyAcc_mean_Z"               "tGravityAcc_mean_X"            "tGravityAcc_mean_Y"           
 [7] "tGravityAcc_mean_Z"            "tBodyAccJerk_mean_X"           "tBodyAccJerk_mean_Y"          
[10] "tBodyAccJerk_mean_Z"           "tBodyGyro_mean_X"              "tBodyGyro_mean_Y"             
[13] "tBodyGyro_mean_Z"              "tBodyGyroJerk_mean_X"          "tBodyGyroJerk_mean_Y"         
[16] "tBodyGyroJerk_mean_Z"          "tBodyAccMag_mean"              "tGravityAccMag_mean"          
[19] "tBodyAccJerkMag_mean"          "tBodyGyroMag_mean"             "tBodyGyroJerkMag_mean"        
[22] "fBodyAcc_mean_X"               "fBodyAcc_mean_Y"               "fBodyAcc_mean_Z"              
[25] "fBodyAccJerk_mean_X"           "fBodyAccJerk_mean_Y"           "fBodyAccJerk_mean_Z"          
[28] "fBodyGyro_mean_X"              "fBodyGyro_mean_Y"              "fBodyGyro_mean_Z"             
[31] "fBodyAccMag_mean"              "fBodyBodyAccJerkMag_mean"      "fBodyBodyGyroMag_mean"        
[34] "fBodyBodyGyroJerkMag_mean"     "tBodyAcc_std_X"                "tBodyAcc_std_Y"               
[37] "tBodyAcc_std_Z"                "tGravityAcc_std_X"             "tGravityAcc_std_Y"            
[40] "tGravityAcc_std_Z"             "tBodyAccJerk_std_X"            "tBodyAccJerk_std_Y"           
[43] "tBodyAccJerk_std_Z"            "tBodyGyro_std_X"               "tBodyGyro_std_Y"              
[46] "tBodyGyro_std_Z"               "tBodyGyroJerk_std_X"           "tBodyGyroJerk_std_Y"          
[49] "tBodyGyroJerk_std_Z"           "tBodyAccMag_std"               "tGravityAccMag_std"           
[52] "tBodyAccJerkMag_std"           "tBodyGyroMag_std"              "tBodyGyroJerkMag_std"         
[55] "fBodyAcc_std_X"                "fBodyAcc_std_Y"                "fBodyAcc_std_Z"               
[58] "fBodyAccJerk_std_X"            "fBodyAccJerk_std_Y"            "fBodyAccJerk_std_Z"           
[61] "fBodyGyro_std_X"               "fBodyGyro_std_Y"               "fBodyGyro_std_Z"              
[64] "fBodyAccMag_std"               "fBodyBodyAccJerkMag_std"       "fBodyBodyGyroMag_std"         
[67] "fBodyBodyGyroJerkMag_std"      "fBodyAcc_meanFreq_X"           "fBodyAcc_meanFreq_Y"          
[70] "fBodyAcc_meanFreq_Z"           "fBodyAccJerk_meanFreq_X"       "fBodyAccJerk_meanFreq_Y"      
[73] "fBodyAccJerk_meanFreq_Z"       "fBodyGyro_meanFreq_X"          "fBodyGyro_meanFreq_Y"         
[76] "fBodyGyro_meanFreq_Z"          "fBodyAccMag_meanFreq"          "fBodyBodyAccJerkMag_meanFreq" 
[79] "fBodyBodyGyroMag_meanFreq"     "fBodyBodyGyroJerkMag_meanFreq"


How was the tidy data set obtained?

1. Load downloaded csv file with command "read.csv" - train/test data separately
2. Combine train/test data together by row concatenation with command "rbind"
3. Extract measurements from file features.txt; Subset on the mean and standard deviation(std) (using "grep" on terms "-means(), -std(), meanFreq and Mean$" to get measurement names and indexes of columns; change measurement names based on rules of defining column names in R as variables ( - to _, (/) remove, ',' to _)
4. Load subject/activity corresponding to above data
5. Calculate average of measurements on mean/std as steps: Do column combine to data with subject and activity separately, and order data by subject/activity; calculate mean of each measurement column by column on factor of subject and activity using command "aggregate(mean)"; replace subject/activitiy index numbers with "subject No." and specific activitity names; combine averages of subject/activity by row; add column names with above modified measurement names
