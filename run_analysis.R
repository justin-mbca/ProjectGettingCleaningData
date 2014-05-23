#Please submit a link to a Github repo with the code for 
#performing your analysis. The code should have a file run_analysis.R
#in the main directory that can be run as long as the Samsung data is 
#in your working directory. The output should be the tidy data set you submitted for part 1. 

#link of Github repository https://github.com/justin-mbca/ProjectGettingCleaningData


#setwd('/local/workspace01/zhangju/Document/GettingAndCleaningData/project/CI_HAR_Dataset')

#1. Merges the training and the test sets to create one data set.

#load train data set into variable "train"
train <- read.csv("train/X_train.txt",sep="",header=FALSE)
#load test data set into variable "test"
test <- read.csv("test/X_test.txt",sep="",header=FALSE)
#merge train data table and test data table by rows, and save into variable "total"
total <- rbind(train,test)

#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# variables for angle() Should be included? gravityMean tBodyAccMean tBodyAccJerkMean tBodyGyroMean
# how about: meanFreq(): Weighted average of the frequency components to obtain a mean frequency
# grep "meanFreq"

feature <- read.csv("features.txt",sep=" ",header=FALSE)
colnames(feature)=c("index","measurement")
mean_std_feature <- feature[c(grep("-mean()",feature$measurement,fixed = TRUE),
                              grep("-std()",feature$measurement,fixed = TRUE)),]
#grep("meanFreq",feature$measurement,fixed = TRUE),
#grep("Mean$",feature$measurement,fixed = TRUE)
mean_std <- total[mean_std_feature$index]



#3. Rows - Uses descriptive activity names to name the activities in the data set

#fBodyGyro_bandsEnergy_25_32
#replace - with _, replace ( or ) with "", replace "," with ""

ori_meanStd <- mean_std_feature$measurement
mod_meanStd <- gsub('-','_',ori_meanStd)
mod_meanStd <- gsub("[(]","",mod_meanStd)
mod_meanStd <- gsub("[)]","",mod_meanStd)
mod_meanStd <- gsub(',','_',mod_meanStd)

#4. Columns - Appropriately labels the data set with descriptive activity names. 
# https://class.coursera.org/getdata-003/forum/thread?thread_id=55
#You need to replace the numeric entries about activity with english names.

colnames(mean_std) <- mod_meanStd


#5 Creates a second, independent tidy data set with the average of each variable
# for each activity and each subject.

y_train <- read.csv("train/y_train.txt",header=FALSE)
y_test <- read.csv("test/y_test.txt",header=FALSE)
y_total <- rbind(y_train,y_test)[,1]

subject_train <- read.csv("train/subject_train.txt",header=FALSE)
subject_test <- read.csv("test/subject_test.txt",header=FALSE)
subject_total <- rbind(subject_train,subject_test)[,1]


#average by subject

total_Subject <- data.frame(subject_total,mean_std)
total_SortSubject <- total_Subject[order(total_Subject[,1]),]
uniq_subject <- unique(total_SortSubject[,1])
data_subject <-c()
data_subject <- uniq_subject
for(col in seq(2,dim(total_SortSubject)[2])){
  bySubject <- aggregate(total_SortSubject[,col],list(total_SortSubject[,1]),mean)
  mean_bySubject <- bySubject[,2]
  data_subject <- cbind(data_subject,mean_bySubject)
}
data_subject[,1] <- paste("subject",data_subject[,1],sep=" ")
colnames(data_subject) <- c("object",mod_meanStd)

#average by activity 

total_Activity <- data.frame(y_total,mean_std)
total_SortActivity <- total_Activity[order(total_Activity[,1]),]
uniq_activity <- unique(total_SortActivity[,1])

data_activity<-c()
data_activity <- uniq_activity
for(col in seq(2,dim(total_SortActivity)[2])){
  byActivity <- aggregate(total_SortActivity[,col],list(total_SortActivity[,1]),mean)
  mean_byActivity <- byActivity[,2]
  data_activity <- cbind(data_activity,mean_byActivity)
}
activity <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")
data_activity[,1] <- activity

colnames(data_activity) <- c("object",mod_meanStd)

# combine mean of subject and activity
meanStd_SubjectActivity <- data.frame(rbind(data_subject,data_activity))
write.csv(meanStd_SubjectActivity,file="tidyData_Avg_MeanStd.csv",row.names=FALSE)
