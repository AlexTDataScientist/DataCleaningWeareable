setwd("C:/Users/alexandru.toth/datasciencecoursera/data/UCI HAR Dataset")

library(dplyr)

#X == measurements, 561 columns in each file
#7352 rows
X_train <- read.table("./train/X_train.txt", quote="\"", stringsAsFactors=FALSE)
#2947 rows
X_test <- read.table("./test/X_test.txt", quote="\"", stringsAsFactors=FALSE)
#concatenate training and test tables
X_tt <- bind_rows(X_train, X_test)

#561 features matching columns above
features <- read.table("features.txt", quote="\"", stringsAsFactors=FALSE)
#use features as column names
names(X_tt) = features$V2


# select only the needed columns
X_mean <- X_tt[,grepl("mean()", colnames(X_tt))]
X_std <- X_tt[,grepl("std()", colnames(X_tt))]
X <- cbind(X_mean, X_std)
#omit na
X2 <- na.omit(X)

# subject who had the sensors for each row of measurements.
#30 subjects, 7352 rows
subject_train <- read.table("./train/subject_train.txt", quote="\"", stringsAsFactors=FALSE)
#add the test / train label
subject_train2 <- cbind(subject_train, "train")
names(subject_train2) <- c("subject", "folder")
#24	 subjects, 2947 rows
subject_test <- read.table("./test/subject_test.txt", quote="\"")
subject_test2 <- cbind(subject_test, "test")
names(subject_test2) <- c("subject", "folder")
#concatenate training and test subjects
subject_tt <- bind_rows(subject_train2, subject_test2)



#labels for 6 activities
activity_labels <- read.table("./activity_labels.txt", quote="\"", stringsAsFactors=FALSE)


#y == what activity_id the subject was doing
#7352 rows
y_train <- read.table("./train/y_train.txt", quote="\"", stringsAsFactors=FALSE)
#2947 rows
y_test <- read.table("./test/y_test.txt", quote="\"", stringsAsFactors=FALSE)
#concatenate training and test tables
y_tt = bind_rows(y_train, y_test)
#join the activity_id with the activity description
y_activity <- full_join(y_tt, activity_labels)
#drop the redundant id column
y_activity$V1 <- NULL
names(y_activity) <- "activity"

#combine columns from subject, activity, X
X_y_subject_activity <- cbind(subject_tt, y_activity, X2)

#write out raw data
write.table(X_y_subject_activity, "x_y_s_a.txt", sep="\t", row.names = F)


#name is too long
a <- X_y_subject_activity
ncol(a)
#82 columns, group by 1=subject and 3=activity all columns between 4:82
res <- aggregate(a[4:8], c(a[1], a[3]), FUN=mean)
write.table(res, "aggregates.txt", sep="\t", row.names = F)
