## Analysis package description
The Analysis package consist of 3 files. They are "run_analysis.R", "CodeBook.md" and this "README.md" itself.

run_analysis.R
It contains script which performs transformation of raw data to tidy according to these requirements:
1.Merges the training and the test sets to create one data set.
2.Extracts only the measurements on the mean and standard deviation for each measurement. 
3.Uses descriptive activity names to name the activities in the data set
4.Appropriately labels the data set with descriptive variable names. 
5.From the data set in step 4, creates a second, independent tidy data set with the average of 
      each variable for each activity and each subject.
Result tidy data has 68 variables and 180 observations.

CodeBook.md
Contains description of variables of tidy data.

## Steps to get tidy data from raw in pseudocode

Step 1 - Set working directory as root of the data set.
         To check it is correct it is necessary to list files of the working directory
             and there should be files like "activity_labels.txt", "features.txt", and so on and folders like "test" and "train".
Step 2 - 

Step 1 - take the raw file, run version 3.1.2 of summarize software with parameters a=1, b=2, c=3