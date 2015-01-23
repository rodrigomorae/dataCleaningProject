## Read Data
activity_labels <- read.table(file = ".//data//activity_labels.txt", strip.white=T, header=F,comment.char = "")
features_name <- read.table(file = ".//data//features.txt", strip.white=T, header=F,comment.char = "")
x_test <- read.table(file = ".//data//test//x_test.txt", strip.white=T, header=F,comment.char = "")
y_test <- read.table(file = ".//data//test//y_test.txt", strip.white=T, header=F,comment.char = "")
subject_test <- read.table(file = ".//data//test//subject_test.txt", strip.white=T, header=F,comment.char = "")
x_train <- read.table(file = ".//data//train//x_train.txt", strip.white=T, header=F,comment.char = "")
y_train <- read.table(file = ".//data//train//y_train.txt", strip.white=T, header=F,comment.char = "")
subject_train <- read.table(file = ".//data//train//subject_train.txt", strip.white=T, header=F,comment.char = "")
names(x_train) <- features_name[,2]
names(x_test) <- features_name[,2]

## Step1
fullDatasetTemp<-rbind(x_train,x_test)
fullY<-rbind(y_train,y_test)
fullSubject<-rbind(subject_train,subject_test)
fullDatasetTemp$Activity<-fullY[,1]
fullDatasetTemp$Subject<-fullSubject[,1]
fullDataset<-fullDatasetTemp

## Step2
goodColums<-grepl("^(subject|activity)|mean|std",names(fullDataset),ignore.case = TRUE)
meanStdData<-fullDataset[,goodColums]

## Step3
meanStdData=merge(meanStdData,activity_labels,by.x="Activity",by.y="V1",all=TRUE)
meanStdData$Activity <- NULL

## Step4
names(meanStdData)[names(meanStdData)=="V2"] <- "ActivityLabel"
names(meanStdData)<-sub('Acc','AccelerometerSignal',names(meanStdData))
names(meanStdData)<-sub('Gyro','GyroscopeSignal',names(meanStdData))
names(meanStdData)<-sub('Mag','Magnitude',names(meanStdData))
names(meanStdData)<-sub('tBody','TimeOfBody',names(meanStdData))
names(meanStdData)<-sub('Jerk','WithJerkSignal',names(meanStdData))
names(meanStdData)<-sub('fBody','FreqeuncyOfBody',names(meanStdData))
names(meanStdData)<-sub('fBody','FreqeuncyOfBody',names(meanStdData))
names(meanStdData)<-sub('tGravity','TimeOfGravity',names(meanStdData))

## Step5
library(dplyr)
finalData<-aggregate(.~ActivityLabel+Subject,meanStdData,mean)

##optional to save the data in a txt file
##write.table(finalData,file = "outputDataSet.txt",row.names = FALSE)
