library(dplyr)

features <- read.table("UCI HAR Dataset/features.txt")[, 2]
meanandstd <- grep("mean\\(\\)|std\\(\\)", features)
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")[, 2]

# load test dataset
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
colnames(X_test) <- features
X_test <- X_test[, meanandstd]  # extract only mean and std
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
colnames(y_test) <- "activity"
y_test$activity <- as.factor(y_test$activity)
levels(y_test$activity) <- activity_labels
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
colnames(subject_test) <- "subject"
test <- cbind(subject_test, y_test, X_test)

# load training dataset
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
colnames(X_train) <- features
X_train <- X_train[, meanandstd]  # extract only mean and std
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
colnames(y_train) <- "activity"
y_train$activity <- as.factor(y_train$activity)
levels(y_train$activity) <- activity_labels
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
colnames(subject_train) <- "subject"
train <- cbind(subject_train, y_train, X_train)

# merge test and training datasets
data <- rbind(test, train)

# tidy data up a bit
# make variable names lowercase, remove -,(,)
colnames(data) <- gsub("[-()]", "", tolower(colnames(data)))
# arrange data by subject
data <- arrange(data, subject)

# create second dataset
data2 <- data %>% group_by(subject, activity) %>% summarise_all(mean)

# create second dataset file
write.table(data2, "tidydata.txt", row.names = FALSE)