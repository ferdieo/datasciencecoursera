#1. Copy these files:
#C:\Users\Ferdie\Desktop\R\getdata-projectfiles-UCI HAR Dataset\UCI HAR Dataset\train\subject_train.txt
#C:\Users\Ferdie\Desktop\R\getdata-projectfiles-UCI HAR Dataset\UCI HAR Dataset\train\X_train.txt
#C:\Users\Ferdie\Desktop\R\getdata-projectfiles-UCI HAR Dataset\UCI HAR Dataset\train\y_train.txt
#C:\Users\Ferdie\Desktop\R\getdata-projectfiles-UCI HAR Dataset\UCI HAR Dataset\test\subject_test.txt
#C:\Users\Ferdie\Desktop\R\getdata-projectfiles-UCI HAR Dataset\UCI HAR Dataset\test\X_test.txt
#C:\Users\Ferdie\Desktop\R\getdata-projectfiles-UCI HAR Dataset\UCI HAR Dataset\test\y_test.txt
#...to single location to read into r.


#2. Read all files into R
activity_labels <- read.table("activity_labels.txt")
features <- read.table("features.txt")
subject_test <- read.table("subject_test.txt")
subject_train <- read.table("subject_train.txt")
X_train <- read.table("X_train.txt")
y_train <- read.table("y_train.txt")
X_test <- read.table("X_test.txt")
y_test <- read.table("y_test.txt")

#3. Give each table a column with row_id for merging tables

subject_test$row_id<-seq.int(nrow(subject_test))
subject_train$row_id<-seq.int(nrow(subject_train))
X_train$row_id<-seq.int(nrow(X_train))
y_train$row_id<-seq.int(nrow(y_train))
X_test$row_id<-seq.int(nrow(X_test))
y_test$row_id<-seq.int(nrow(y_test))

#4. Install and load plyr
install.packages("plyr")
library(plyr)

#5. Merge the three test tables
test<-merge(y_test,subject_test,by="row_id")
test<-rename(test,c("V1.x"="activity","V1.y"="subject"))
test<-merge(X_test,test,by="row_id")

#6. Drop the row_id column
test$row_id<-NULL

#7. Merge the three test tables
train<-merge(y_train,subject_train,by="row_id")
train<-rename(train,c("V1.x"="activity","V1.y"="subject"))
train<-merge(X_train,train,by="row_id")

#8. Drop the row_id column
train$row_id<-NULL

#9. Union the two datasets test and train
test_train<-rbind(test,train)

#10. Apply column names
names(test_train)<-append(append(as.vector(features$V2),"activity"),"subject")

#11. Load dplyr
library(dplyr)

#12. Convert to dplyr data table
test_train_df <- tbl_df(test_train)

#13. Get std, mean columns with activity and subject
final1 <- test_train_df[,grepl("std()",colnames(test_train_df))|grepl("mean()",colnames(test_train_df))|grepl("activity",colnames(test_train_df))|grepl("subject",colnames(test_train_df))]

#14. Rename columns in activity_labels for join
names(activity_labels)<-c("activity","name")

#15. Join to get nice names for activities
final2<-inner_join(activity_labels,final1)

#16. Remove activity code column
final2$activity<-NULL

#17. Replaced name column with activity (i.e. change column name)
final3<-mutate(final2,activity=name)
final3$name<-NULL

#18 Reorder columns, bring activity and subject to front
final4<-final3[,c(80,81,1:79)]

#19. Make nicer column names
newcolnames<-colnames(final4)
newcolnames<-gsub("\\(|\\)","",newcolnames)
newcolnames<-gsub("-","_",newcolnames)
newcolnames

#20. Apply column names
names(final4)<-as.vector(newcolnames)

#***final4 is first data set.

#21. Create second summarised data set

final5 <- final4 %>% group_by(activity,subject) %>% summarise_each(funs(mean))

#22. Create column names
columnnames<-colnames(final5)
columnnames<-paste("mean_of_",columnnames[],sep="")
columnnames<-gsub("mean_of_activity","activity",columnnames)
columnnames<-gsub("mean_of_subject","subject",columnnames)

#23. Apply column names
names(final5)<-as.vector(columnnames)

#***final5 is second data set.
