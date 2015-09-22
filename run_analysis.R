#load package dplyr
library(dplyr)
#load package tidyr
library(tidyr)

# Read the test data set and subjects
data_test <- read.table("UCI HAR Dataset/test/X_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
#Change the name of the variable to subject
subject_test<-rename(subject_test, subject=V1)

# Read the test activities
activity_test <- read.table("UCI HAR Dataset/test/y_test.txt")
#Change the name of the variable to activity
activity_test<-rename(activity_test, activity=V1)

# Read the train data set (data, subjects and activities)
data_train <- read.table("UCI HAR Dataset/train/X_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
#Change the name of the variable to subject
subject_train<-rename(subject_train, subject=V1)

# Read the train activities
activity_train <- read.table("UCI HAR Dataset/train/y_train.txt")
#Change the name of the variable to activity
activity_train<-rename(activity_train, activity=V1)

# STEP 1: Merges the training and the test sets to create one data set
# 1.1: Add subject and activity variables to test data set (data_test_x)
data_test <- bind_cols(subject_test, activity_test,data_test)

# 1.2: Add subject and activity variables to train data set (data_train_x)
data_train <- bind_cols(subject_train, activity_train, data_train)

# 1.3-Merge test and train data sets
init_data_complete <- bind_rows(data_test, data_train)

# Step 2: Extracts only the measurements on the mean and standard deviation for each measurement
# 2.1: Name all variables names with the features names
features <- read.table("UCI HAR Dataset/features.txt")
# Add the feature names as variable names together with "subject"and "activity"
colnames(init_data_complete) <- c("subject", "activity", as.vector(features[,2]))

# 2.2: Extract the feature names with mean and std
selectedNames <- grep("[mM]ean|std", features$V2, value = TRUE)

#2.3: select the columns with the selected names
selected_data_set <- subset(init_data_complete, select = c("subject", "activity", selectedNames))

# Step 3: Uses descriptive activity names to name the activities in the data set
# 3.1: Read the activity names
act_names <- read.table("UCI HAR Dataset/activity_labels.txt")
# 3.2 Change the values of the activity variable
for(i in seq_len(nrow(selected_data_set))){
  selected_data_set$activity[i] <- as.character(act_names[selected_data_set$activity[i], "V2"])
}

# Step 4: Appropriately labels the data set with descriptive variable names
names(selected_data_set) <- gsub("^t", "time", names(selected_data_set))
names(selected_data_set) <- gsub("Acc", "Accelerometer", names(selected_data_set))
names(selected_data_set) <- gsub("Gyro", "Gyroscope", names(selected_data_set))
names(selected_data_set) <- gsub("^f", "frequency", names(selected_data_set))
names(selected_data_set) <- gsub("\\()", "", names(selected_data_set))
names(selected_data_set) <- gsub("mean", "Mean", names(selected_data_set))
names(selected_data_set) <- gsub("std", "STD", names(selected_data_set))
names(selected_data_set) <- gsub("BodyBody", "Body", names(selected_data_set))
names(selected_data_set) <- gsub("Mag", "Magnitude", names(selected_data_set))

# Step 5: From the data set in step 4, creates a second, 
# independent tidy data set with the average of each variable for each activity and each subject
# 5.1 Group by subject and activity and then calculate the average of all variables
tidy_data<-group_by(selected_data_set, subject, activity) %>%
  summarize_each(funs(mean))
  
