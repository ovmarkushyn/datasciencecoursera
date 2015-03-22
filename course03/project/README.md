# Analysis package description

The Analysis package consist of 3 files:
* run_analysis.R
* CodeBook.md
* README.md itself

##run_analysis.R
###Environment
* It was tested on Windows 7 64bit, RStudio version 0.98.1091, R version 3.1.2 64bit.
* The script uses two packages dplyr and plyr. They must be installed before script usage.
* The script assumes that the working directory is the root of the data set.
To check it is correct it is necessary to list files of the working directory and there should be files like "activity_labels.txt", "features.txt", and so on and folders like "test" and "train". Example: setwd("E:/Education/Coursera/JonnsHopkins-DataScience/git-repo/datasciencecoursera/course03/project/Dataset"); list.files()

###Requirements
Performs transformation of raw data to tidy according to these requirements:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of 
      each variable for each activity and each subject.

###Result
* Result tidy data set has 68 variables and 180 observations.
* Tidy data are saved into working directory under name tidy_data.txt.
* Additionally, the tidy data are returned from the function.

##CodeBook.md
Contains description of variables of tidy data.

# Steps to get tidy data set from raw set (pseudocode)
1. Read test observations from test/X_test.txt
2. Bind (concatenate, append) observations from train/X_train.txt
3. Set column names from features.txt. It contains 561 row and read earlier observations set has also 561 column
4. Extract from the whole data set (with 561 columns) only -mean() and -std() columns. It is dictated with requirement 2.
5. Bind subject column to data set from previous step. Subject column is concatenatanation of two files "test/subject_test.txt" and "train/subject_train.txt". Observations from seconds file need to be appended to the ones from the first one and overall set (with just a one variable) need to be binded (concatenated, appended) to data set from previous step. Name column "subject"
6. To implement requirement 3 it is necessary to make steps 7-12.
7. Read "test/y_test.txt" and bind (concatenate, append) to it "train/y_train.txt". Result will be set with just a one column contaning activity ids.
8. Bind the activity id column to the data set. Name the column activityid
9. Read activity names from "activity_labels.txt". It contains two columns: activity id and activity name.
10. Merge the activity names with the data set by dataset.activityid and first column of set got from "activity_labels.txt".
11. Set name of merged activity name column to "activity".
12. Remove unnecessary column activityid.
13. To implement requirement 4 it is necessary to make steps 14-16.
14. Remove symbols like '-', '(', ')'
15. Lower case column names.
16. Replace prefix 't' with time and prefix 'f' with fourier (FFT, Fast Fourier Transform).
17. To implement requirement 4 it is necessary to make steps 18-19.
18. Group the data set by activity and subject.
19. Summarise the groups with mean.
20. Save the data set to file "tidy_data.txt"
