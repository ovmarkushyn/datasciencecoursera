# Implementation of Getting and Cleaning Data Course Project
run_analysis <- function(){
    library(plyr)
    library(dplyr)
    
    # Read observations
    tidy<-read.table("test/X_test.txt")
    tidy<-rbind(tidy, read.table("train/X_train.txt"))
    
    # Set column names
    cols561<-read.table("features.txt")
    colnames(tidy)<-cols561$V2
    
    # 2.Extracts only the measurements on the mean and standard deviation for each measurement
    tidycolnames<-colnames(tidy)
    tidymeanstd<-tidycolnames[grepl("\\-(mean|std)\\(\\)", tidycolnames)==TRUE]
    tidy<-subset(tidy, select=tidymeanstd )
    
    # Bind subject variable
    subj<-read.table("test/subject_test.txt")
    subj<-rbind(subj, read.table("train/subject_train.txt"))
    tidy<-cbind(tidy, subj)
    addedcolumnindex <- length(colnames(tidy))
    colnames(tidy)[addedcolumnindex]="subject"
    
    # 3.Uses descriptive activity names to name the activities in the data set
    # Read activity ids
    activityids<-read.table("test/y_test.txt")
    activityids<-rbind(activityids, read.table("train/y_train.txt"))
    # Add activity id variable
    tidy<-cbind(tidy, activityids)
    addedcolumnindex <- length(colnames(tidy))
    colnames(tidy)[addedcolumnindex]="activityid"
    # Read activity names
    activities<-read.table("activity_labels.txt")
    # merge activity names with tidy data withby activity id
    # WARNING: changes rows and columns ordering
    tidy<-merge(tidy, activities, by.x="activityid", by.y="V1")
    # Rename merged activity name variable name from V2 to activity
    tidy<-plyr::rename(tidy, replace=c("V2" = "activity"))
    # Remove unnecessary anymore activitid column
    tidy<-select(tidy, -activityid)
    
    # 4.Appropriately labels the data set with descriptive variable names. 
    # Removes inappropriate symbols
    colnames(tidy)<-make.names(colnames(tidy), unique=FALSE )
    # Lower case
    colnames(tidy)<-tolower(colnames(tidy))
    # Replace 
    #         prefix t with time
    #                f with fourier (FFT, Fast Fourier Transform)
    #         '.' with emptiness
    colnames(tidy)<-
        lapply(colnames(tidy), 
               function(x){
                   x<-sub("^t", "time", x); 
                   x<-sub("^f", "fourier", x); 
                   x<-gsub("\\.", "", x)})    
    
    # 5.From the data set in step 4, creates a second, 
    #     independent tidy data set with the average of each variable
    #     for each activity and each subject
    tidy<-group_by(tidy, activity, subject) %>% 
        summarise_each( funs( mean ) )
    
    # Write tidy data
    file = "tidy_data.txt";
    write.table(tidy, file, row.name=FALSE)
    
    tidy
}