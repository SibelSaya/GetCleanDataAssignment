Getting and Cleaning Data Course Assignment

Each of 180 columns in the tidy dataset correspond to each of 30 participants (number preceding "." in column name) for six types of activities (after ".").

Training and test data were combined.  Each measurement was taken multiple times for all participants performing each of the 6 tasks.  Summary statistics for these measurments were reported in the raw data set (e.g. mean, standard deviation, min, max plus others).  Only variables corresponding to means and standard deviations were included in the tidy dataset.

Rows correspond to average values of the means and standard deviations for the following features measured.  Some features have been taken in the x, y and z dimensions, denoted by "-XYZ" suffix of variable name:

tBodyAcc-XYZ

tGravityAcc-XYZ

tBodyAccJerk-XYZ

tBodyGyro-XYZ

tBodyGyroJerk-XYZ

tBodyAccMag

tGravityAccMag

tBodyAccJerkMag

tBodyGyroMag

tBodyGyroJerkMag

fBodyAcc-XYZ

fBodyAccJerk-XYZ

fBodyGyro-XYZ

fBodyAccMag

fBodyAccJerkMag	

fBodyGyroMag

fBodyGyroJerkMag



Transforation of data:

1. import all data

2. take list of observations (i.e. variables) from features.txt file and label the test and training sets with these variable names

3. take the activity number (i.e. sitting, walking etc.) and add as column to data

4. take the subject number (i.e. between 1&30) add as column to data

5. combine training and test data as new rows

6. take all columns with either "mean" or "std" in the variable name (but not "meanFreq") using grep, plus two columns with activity and subject number and create new df with just this data

7. replace coded activity type (i.e. 1 to 6) with descriptive names

8. split means/std data file by subject number and activity

9. sapply column means for all data columns (1-6) as split above

10. write text file with tidy data
