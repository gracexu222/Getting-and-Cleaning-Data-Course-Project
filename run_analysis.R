unzip("UCI HAR Dataset.zip")
XTest<- read.table("UCI HAR Dataset/test/X_test.txt")
Ytest<- read.table("UCI HAR Dataset/test/Y_test.txt")
SubjectTest<- read.table("UCI HAR Dataset/test/subject_test.txt")

XTrain<- read.table("UCI HAR Dataset/train/X_train.txt")
YTrain<- read.table("UCI HAR Dataset/train/Y_train.txt")
SubjectTrain<- read.table("UCI HAR Dataset/train/subject_train.txt")

features<-read.table("UCI HAR Dataset/features.txt")
activity<-read.table("UCI HAR Dataset/activity_labels.txt")

X<-rbind(XTest, XTrain)
Y<-rbind(YTest, YTrain)
subject<-rbind(SubjectTest, SubjectTrain)

dim(X)
dim(Y)
dim(subject)

index<-grep("mean\\(\\)|std\\(\\)", features[,2])
length(index)

X<-X[,index]
dim(X)

Y[,1]<-activity[Y[,1],2]
head(Y)

names<-features[index,2]
names(X)<-names
names(subject)<-"SubjectID"
names(Y)<-"Activity"

CleanedData<-cbind(subject, Y, X)
head(CleanedData[,c(1:4)])

CleanedData<-data.table(CleanedData)
TidyData <- CleanedData[, lapply(.SD, mean), by = 'SubjectID,Activity']
dim(TidyData)

write.table(TidyData, file = "Tidy.txt", row.names = FALSE)