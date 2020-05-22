##1 read data and creates one data set
x_test <- read.table("C:\\Users\\User\\Desktop\\run_analysis\\test\\X_test.txt")
y_test <- read.table("C:\\Users\\User\\Desktop\\run_analysis\\test\\y_test.txt")
sub_test <- read.table("C:\\Users\\User\\Desktop\\run_analysis\\test\\subject_test.txt")
x_train <- read.table("C:\\Users\\User\\Desktop\\run_analysis\\train\\X_train.txt")
y_train <- read.table("C:\\Users\\User\\Desktop\\run_analysis\\train\\y_train.txt")
sub_train <- read.table("C:\\Users\\User\\Desktop\\run_analysis\\train\\subject_train.txt")
xtotal <- rbind(x_test, x_train)
ytotal <- rbind(y_test, y_train)
subtotal <- rbind(sub_test, sub_train)
activity_labels <- read.table("C:\\Users\\User\\Desktop\\run_analysis\\activity_labels.txt")
variables <- read.table("C:\\Users\\User\\Desktop\\run_analysis\\features.txt")
##2 collects mean and std
selectedv <- variables[grep("mean\\(\\)|std\\(\\)",variables[,2]),]
xtotal <- xtotal[,selectedv[,1]]
##3 descriptive names
colnames(ytotal) <- "activity"
ytotal$activitylabel <- factor(ytotal$activity, labels = as.character(activity_labels[,2]))
activitylabel <- ytotal[,-1]
##4 appropriate names
colnames(xtotal) <- variables[selectedv[,1],2]
##5 tidy data
colnames(subtotal) <- "subject"
total <- cbind(xtotal, activitylabel, subtotal)
totalmean <- total %>% group_by(activitylabel, subject) %>% summarize_each(funs(mean))
write.table(totalmean, file = ".\\run_analysis\\tidydata.txt", row.names = FALSE, col.names = TRUE)