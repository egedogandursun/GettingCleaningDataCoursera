library(dplyr)


X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")
Subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")
Subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
var_names <- read.table("./UCI HAR Dataset/features.txt")
acv_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
X_total <- rbind(X_train, X_test)
Y_total <- rbind(Y_train, Y_test)
Subject_total <- rbind(Subject_train, Subject_test)
selected_var <- var_names[grep("mean\\(\\)|std\\(\\)",var_names[,2]),]
X_total <- X_total[,selected_var[,1]]
colnames(Y_total) <- "activity"
Y_total$activitylabel <- factor(Y_total$activity, labels = as.character(activity_labels[,2]))
activitylabel <- Y_total[,-1]
colnames(X_total) <- variable_names[selected_var[,1],2]
colnames(Sub_total) <- "subject"
total <- cbind(X_total, activitylabel, Sub_total)
total_mean <- total %>% group_by(activitylabel, subject) %>% summarize_each(funs(mean))
write.table(total_mean, file = "./UCI HAR Dataset/tidydata.txt", row.names = FALSE, col.names = TRUE)
