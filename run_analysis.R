
# Requirement 1: Merges the training and the test sets to create one data set.
# Reading the training and the test sets, labels and subjects and binding them together 
# as single data frames using rbind. We end up with 3 different data frames for subjects (s), labels(y) and sets(x).

x1 <- read.table("Dataset/train/X_train.txt")
x2 <- read.table("Dataset/test/X_test.txt")
x <- rbind(x1, x2)

s1 <- read.table("Dataset/train/subject_train.txt")
s2 <- read.table("Dataset/test/subject_test.txt")
s <- rbind(s1, s2)

y1 <- read.table("Dataset/train/y_train.txt")
y2 <- read.table("Dataset/test/y_test.txt")
y <- rbind(y1, y2)

# Requirement 2: Extracts only the measurements on the mean and standard deviation for each measurement.
# Reads the features and uses the grep command to select only those involving either mean or standard deviation.
# It then uses that shortened dataframe to select only the appropriate columns for our measurement set dataframe
# and using the gsub() and tolower() commands their names are decapitalized and the parentheses are removed.

features <- read.table("Dataset/features.txt")
features_mean_std <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
x <- x[, features_mean_std]
names(x) <- features[features_mean_std, 2]
names(x) <- gsub("\\(|\\)", "", names(x))
names(x) <- tolower(names(x))

# Requirement 3: Uses descriptive activity names to name the activities in the data set.
# The activity labels are being read and processed with the help of gsub and tolower commands. Then the 
# label dataframe is processed using our previous work and the names of the column of the labels are 
# set as "activity"

activities <- read.table("Dataset/activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
y[,1] = activities[y[,1], 2]
names(y) <- "activity"

# Requirement 4: Appropriately labels the data set with descriptive activity names.
# Uses the names function to name as "subject" the column of dataframe and creates a new dataframe, merging the three
# dataframes created and processed earlier (sets of measurements, subjects and labels) using cbind()
names(s) <- "subject"
clean <- cbind(s, y, x)


# Requirement 5: Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.
# A new data set is created for which the average of each variable for each activity and for each subject is calculated in a
# for loop and finally placed in the new dataframe which gets exported as a text file with the help of write.table() command.

uniqueSub = unique(s)[,1]
countSub = length(unique(s)[,1])
countActivities = length(activities[,1])
countCols = dim(clean)[2]
result = clean[1:(countSub*countActivities), ]

row = 1
for (i in 1:countSub) {
  for (a in 1:countActivities) {
    result[row, 1] = uniqueSub[i]
    result[row, 2] = activities[a, 2]
    temp <- clean[clean$subject==i & clean$activity==activities[a, 2], ]
    result[row, 3:countCols] <- colMeans(temp[, 3:countCols])
    row = row+1
  }
}
write.table(result, "dataset.txt", row.name=FALSE)