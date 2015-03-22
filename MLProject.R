#setting directory
setwd("D:/COURSERA/Data science/Machine learning/Project")
getwd()

#downloading data
?read.csv
train<-read.csv("pml-training.csv",dec=".",na.strings = c("NA","#DIV/0!"))
str(train)
names(train)
dim(train)
#getting rid of new window=yes because in prediction assignment we are to predict 
#only new_window=="no"
train2<-train[train$new_window=="no",]
n<-nrow(train2)

#calculate missing values
count_missing<-apply(train2,2,function(x) sum(is.na(x)))
head(count_missing,20)
#getting rid of columns with more than 99% missing values
filled<-count_missing<0.99*n
train3<-train2[,filled]
str(train3)
train4<-train3[,-c(1,6)]
dim(train4)
str(train4)

#let's use random forest
library(caret)
set.seed(121212)
#splitting data into training and test sets
inTrain<-createDataPartition(y=train4$classe,p=0.7,list=FALSE)
training<-train4[inTrain,]
testing<-train4[-inTrain,]
summary(training)

#estimating model (lasts quite long)
forest<-train(classe~.,method="rf",data=training,prox=TRUE,trControl=trainControl(method="cv",number=10)) 
varImp(forest)
names(forest)
forest$results

#checking for the out of sample error
pred<-predict(forest,testing)
head(pred)

#classification table
class.table<-table(testing$classe,pred)
( outofsample.missclass.error<-1-sum(diag(class.table))/sum(class.table) )

#prediction for the assignment:
test<-read.csv("pml-testing.csv",dec=".",na.strings = c("NA","#DIV/0!"))
answers<-predict(forest,test)

#creating the function for submission
pml_write_files = function(x){
  n = length(x)
  for(i in 1:n){
    filename = paste0("problem_id_",i,".txt")
    write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
  }
}
#creating txt files for submitting
pml_write_files(answers)
