# You should create one R script called run_analysis.R that does the following.
# 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each 
# measurement.
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names.
# From the data set in step 4, creates a second, independent tidy
# data set with the average of each variable for each activity and each subject.

##Set working paths
strTestX <- "./Dataset/test/X_test.txt"
strTestY <- "./Dataset/test/Y_test.txt"
strTestS <- "./Dataset/test/subject_test.txt"

strTrainX <- "./Dataset/train/X_train.txt"
strTrainY <- "./Dataset/train/Y_train.txt"
strTrainS <- "./Dataset/train/subject_train.txt"

##Datasets
TestX <- read.table(strTestX)
TestY <- scan(strTestY)
TestS <- scan(strTestS)

TrainX <- read.table(strTrainX)
TrainY <- scan(strTrainY)
TrainS <- scan(strTrainS)

#Get collum names
cNames <- read.table("./Dataset/features.txt")

#Set collumn names
names(TestX) <- cNames$V2
names(TrainX) <- cNames$V2

#Append subjects and activities
TrainX$activity <- TrainY
TestX$activity <- TestY

TrainX$subject <- TrainS
TestX$subject <- TestS

#merge dataset
ds <- rbind(TestX,TrainX)

#identify mean and std cols
meanCol <- grepl( "mean\\(\\)" , names(ds) )
stdCol <- grepl( "std\\(\\)" , names(ds) )

#select only mean and std columns
dsSel <- ds[,meanCol|stdCol]
dsSel$activity <- ds$activity
dsSel$subject <- ds$subject

#read activity labels
act <- read.table("./Dataset/activity_labels.txt")
dsSel$ActivityLabel <- factor(dsSel$activity,levels = unique(dsSel$activity),
                              labels = act$V2)
#Create an independent dataset with avearages for each subject and each activity
dsGroup <- aggregate(dsSel[,1:68], by=list(dsSel$subject,dsSel$activity), mean )
dsGroup$ActivityLabel <- factor( dsGroup$activity,
                                 levels = unique(dsGroup$activity),
                                 labels = act$V2 )

#write down the tidy dataset
write.table(dsGroup[,3:71],"tidy_dataset.txt",row.names = FALSE)
