#first collect and read all the data we need, for both sets
testdata<-read.table("test/X_test.txt")
testsubjects<-read.table("test/subject_test.txt")
testlabels<-read.table("test/y_test.txt")

traindata<-read.table("train/X_train.txt")
trainsubjects<-read.table("train/subject_train.txt")
trainlabels<-read.table("train/y_train.txt")

#individually combine the two data sets to form test and
#train data, then combine them together.
test<-cbind(testsubjects,testlabels,testdata)
train<-cbind(trainsubjects,trainlabels,traindata)
all<-rbind(test,train)

#using the features table, we create an index that will give us all 
#the std and mean columns.
#this will only return features that have mean() or std()
#not those with mean in the middle of the name
features<-read.table("features.txt", stringsAsFactors = FALSE)
index<-grep("mean[()]|std[()]",features$V2)

myindex<-c(1,2,index+2)
#this accounts for the fact we need to include the activity and subject number.

#now filter the data to just the fields we want
allneat<-all[,myindex]


#makes a vector that will be used for renaming the labels in the data sets.
labels<-c("walking","walking up", "walking down","sitting", "standing", "laying down")

#replaces activity numbers (currently V1.1) with the labels from the vector above.
for (i in 1:length(allneat$V1)){
    for (j in 1:6){
        if (allneat$V1.1[i]==j){allneat$V1.1[i]=labels[j]}
    }
}

#we will now build clearer label names, by editing the ones in the
#features table, by repeated use of grep.

names<-grep("mean[()]|std[()]",features$V2, value = TRUE)

#first, we make a clear time or force prefix for each variable.
names1=c()
for (i in 1:length(names)){
    if (substr(names[i],1,1)=="t"){
        names1[i]=paste("time- ",substr(names[i],2,nchar(names[i])))
    }
    else
        names1[i]=paste("force- ",substr(names[i],2,nchar(names[i])))
}

#the following grep functions will remove brackets following mean and
#std, unabbreviate terms like Mag and Acc, specify which axes the variable
#refers to, remove repetition of Body on the some of the final names, and
#then remove any double spacing introduced in this process.

names1<-sub("-mean[()][()]"," mean",names1)
names1<-sub("-std[()][()]"," standard deviation",names1)
names1<-sub("-X"," x axis",names1)
names1<-sub("-Y"," y axis",names1)
names1<-sub("-Z"," z axis",names1)
names1<-sub("Acc"," acceleration ",names1)
names1<-sub("Gyro"," gyroscope ",names1)
names1<-sub("Mag"," magnitude ",names1)
names1<-sub("BodyBody","Body",names1)
names1<-sub("  "," ",names1)

#adds our final two labels, makes the names1 vector all lower case, and
#renames our table.
allnames<-c("subject number","activity",tolower(names1))
colnames(allneat)<-allnames

#this data will be presented as a table entirely of mean values.
#It will not specify 'mean' anywhere, but will assume the reader knows it
#is a table of mean values. The columns will specify either the subject
#id (an integer), or the activity name as assigned previously.
#The row names will each be a variable, using the clearer names produced in
#part 4

mean<-data.frame(matrix(ncol=37,nrow=66))
colnames(mean)<-c(labels,1:30)
rownames(mean)<-names1

for (i in 1:length(names1)){
    for (j in 1:6){
        mean[i,j]=mean(allneat[,i+2][allneat[,2]==colnames(mean)[j]])
    }
    for (j in 7:36)
        mean[i,j]=mean(allneat[,i+2][allneat[,1]==colnames(mean)[j]])
}

write.table(mean,file = "tidydata.csv")
