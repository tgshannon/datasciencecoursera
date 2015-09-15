# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, create a second, independent tidy data set with the average
#     of each variable for each activity and each subject.

#
# 1. Merge the training and the test sets to create one data set.
#
# 30 volunteers age: 19-48 (subject_train.txt)
# perform six activities: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS,
#  SITTING, STANDING, LAYING. 
# Sample: 3 axial linear acceleration and 3 axial angular accelerationclas

feature <- read.table('features.txt');
X1 <- read.table('test/X_test.txt');
X2 <- read.table('train/X_train.txt');
X <- rbind(X1, X2);
colnames(X) <- feature$V2;            # 4. label variable names with descriptive labels
y1 <- read.table('test/y_test.txt');
y2 <- read.table('train/y_train.txt');
s1 <- read.table('test/subject_test.txt');
s2 <- read.table('train/subject_train.txt');
y <- cbind(rbind(s1,s2),rbind(y1, y2));
X <- cbind(y, X);

X1 <- X2 <- y1 <- y2 <- s1 <- s2 <-y <- NULL;
# 2. Extract the measurements on the mean and standard deviation for each measurement. 
meanCol <- grepl("-mean()", names(X), fixed = TRUE);
stdCol <- grepl("-std()", names(X), fixed = TRUE);
actCol <- grepl("V1", names(X));      # grabs both subject and activity!!
X <- X[, meanCol|stdCol|actCol];
colnames(X)[1:2] <- c("subject", "activity");

# 3. Use descriptive activity names to name the activities in the data set

lbls <- read.table('activity_labels.txt');
X$activity <- factor(X$activity, levels = lbls$V1, labels = lbls$V2);
X$subject <- factor(X$subject);

# 5. create an independent tidy dataset with the average of each variable 
#      by subject and activity

tidy <- melt(X, id = names(X[1:2]), measure.vars = names(X[3:length((X))]));
tidy <- aggregate(tidy$value, list(tidy$subject, tidy$activity, tidy$variable), mean);
str(tidy);
