# Getting and Cleaning Data Project

## Project Goals
Create a script (run_analysis.R) that performs the following steps:
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive activity names.
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## How the script works
1. The script first reads the text files containing the data set for test and train data. It also reads the subjects and activities for each data set.
2. Tests and train data are merged along with subject and activities variables to create an initial complete data set.
3. The script reads the names of all variables (features) and name the variables of the initial data set with those names. Then, only the mean and std variables are selected creating a reduced data set.
4. The names of the reduced data set variables are changed by more descriptive names.
5. A new data frame is created grouping the reduced data set by subject and activity and calculating the mean of all variables.

## Dependencies
The script uses dplyr and tidyr packages. The script also assumes that the files to read are available in the user working directory.

