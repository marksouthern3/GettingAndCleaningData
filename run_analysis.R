features <- read.table("UCI HAR Dataset/features.txt")[, 2]
meanandstd <- grep("mean|std", features)
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")[, 2]

# load test dataset
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
colnames(X_test) <- features
X_test <- X_test[, meanandstd]  # extract only mean and std
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
colnames(y_test) <- "Activity"
y_test$Activity <- as.factor(y_test$Activity)
levels(y_test$Activity) <- activity_labels
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
colnames(subject_test) <- "Subject"
test <- cbind(subject_test, y_test, X_test)

# load training dataset
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
colnames(X_train) <- features
X_train <- X_train[, meanandstd]  # extract only mean and std
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
colnames(y_train) <- "Activity"
y_train$Activity <- as.factor(y_train$Activity)
levels(y_train$Activity) <- activity_labels
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
colnames(subject_train) <- "Subject"
train <- cbind(subject_train, y_train, X_train)

# merge test and training datasets
data <- rbind(test, train)
