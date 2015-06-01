#import all data
act_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
feat <- read.table("./UCI HAR Dataset/features.txt")

subtest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("./UCI HAR Dataset/test/Y_test.txt")

subtrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("./UCI HAR Dataset/train/Y_train.txt")

#take list of observations (i.e. variables) from features.txt file and label the
#test and training sets with these variable names
varname <-  make.names(feat[,2], unique=TRUE)
colnames(xtest) <- varname
colnames(xtrain) <- varname

#take the activity number (i.e. sitting, walking etc.) from y_test file and 
#add as column to test data
library(plyr)
library(dplyr)
act <- ytest[,1]
xtest <- mutate(xtest, act = factor(act))
#take the subject number (i.e. between 1&30) from subject file and 
#add as column to test data
subj <- subtest[,1]
xtest <- mutate(xtest, subj = subj)

#same as two steps above but add to training df
act <- ytrain[,1]
xtrain <- mutate(xtrain, act = factor(act))
subj <- subtrain[,1]
xtrain <- mutate(xtrain, subj = subj)

#combine training and test data as new rows
alldata <- rbind(xtrain, xtest)

#take all columns with either "mean" or "std" in the variable name (but not "meanFreq)
#and add their to column number to vector colindex; add two last columns with
#activity and subject number
colindex <- intersect(grep("std|mean", varname),grep("meanFreq", varname, invert=TRUE))
colindex <- append(colindex, c(562, 563))

#take only columns from colindex and create new df with just this data
meanstddata <- alldata[,colindex]

#replace coded activity type (i.e. 1 to 6) with descriptive names from
#activity_labels.txt file
meanstddata$act <- mapvalues(meanstddata$act, from = act_labels[,1],
                              to = as.character(act_labels[,2]))

#split means/std data file by subject number and activity
s<-split(meanstddata, list(meanstddata$subj,meanstddata$act))
#sapply column means for all data columns (1-66) split by above
tidydata<-as.data.frame(sapply(s, function(meanstddata) colMeans(meanstddata[,1:66],
                                                          na.rm=TRUE)))

write.table (tidydata, file="tidydata.txt", row.names=FALSE)
        
