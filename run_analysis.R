## run_analysis.R
# Assumes it runs in the directory where the script exists.

## download and extract the data files
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./DataSet.zip")
unzip("DataSet.zip")

# Save the working directory 
WorkDir<-getwd()  

## read data
setwd("./UCI HAR Dataset")
features<-read.table("features.txt")
activity_labels<-read.table("activity_labels.txt")

# Search only the column indces related to mean/std data 
indices_mean_std<-grep("mean|std",features$V2) 

# Read test data
setwd("./test")
X_test<-read.table("X_test.txt")
y_test<-read.table("y_test.txt")
subject_test<-read.table("subject_test.txt")

# Extract only the names.
names(X_test)<-features$V2
names(y_test)<-"labels"
names(subject_test)<-"subjects"

# Read training data
setwd("../train")
X_train<-read.table("X_train.txt")
y_train<-read.table("y_train.txt")
subject_train<-read.table("subject_train.txt")

# Extract only the names.
names(X_train)<-features$V2
names(y_train)<-"labels"
names(subject_train)<-"subjects"

# Change to the working directory 
setwd(WorkDir)


# Extracts only the measurements on the mean and standard deviation for each sample. 
colnames_mean_std <-colnames(X_test)[indices_mean_std]

# Find the subset related to the mean and std, including subject and y labels. 
X_test_subset<-cbind(subject_test,y_test,subset(X_test,select=colnames_mean_std))
X_train_subset<-cbind(subject_train,y_train,subset(X_train,select=colnames_mean_std))

# Merges the training and the test sets to create one data set.
merged_data<-rbind(X_test_subset, X_train_subset)

# Exclude subject and label
sub_merged <- merged_data[,3:ncol(merged_data)]

## Creates a second, independent tidy data set with the average of each variable for each activity and each subject
tidy_data<-aggregate(sub_merged,list(Subject=merged_data$subjects, Activity=merged_data$labels), mean)
tidy_data<-tidy_data[order(tidy_data$Subject),]

## Use descriptive activity names to name the activities in the data set
tidy_data$Activity<-activity_labels[tidy_data$Activity,2]

write.table(tidy_data, file="./tidy_data.txt", sep="\t", row.names=FALSE)

