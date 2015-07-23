# Getting & Cleaning Data - Course Project - Draft Version 1.1
# T. Debus - 07 / 2015
#

library(data.table)
library(plyr)
library(dplyr)


# Get base data from files as column classes
# Ensure working directory pounts to the correct Test Data 

x_hdr <- read.table("test/X_test.txt", nrows=5)
x.classes <- lapply(x_hdr, class)

y_hdr <- read.table("test/y_test.txt", nrows=5)
y.classes <- lapply(y_hdr, class)

lab <- read.table("features.txt", colClasses = "character")
lab[,3]  <-gsub("()-", ".", lab$V2, fixed = TRUE) 
lab[,4]  <-gsub(",", ".", lab$V3, fixed = TRUE) 
lab[,5]  <-gsub("BodyBody", "Body", lab$V4, fixed = TRUE) 

act <- read.table("activity_labels.txt", col.names=c("ActID", "Activity"))


# Read the test tables
x_tst <- read.table("test/X_test.txt", colClasses=x.classes, col.names = as.factor(lab[,5]))
x_red <- select(.data=x_tst, grep("ean|std",colnames(x_tst)))
y_tst <- read.table("test/y_test.txt", colClasses=y.classes, col.names=c("ActID"))
subj <- read.table("test/subject_test.txt", col.names=c("Subject"))

base1 <- cbind(x_red, y_tst, subj)

# Read the train tables
x_tst <- read.table("train/X_train.txt", colClasses=x.classes, col.names = as.factor(lab[,5]))
x_red <- select(.data=x_tst, grep("ean|std",colnames(x_tst)))
y_tst <- read.table("train/y_train.txt", colClasses=y.classes, col.names=c("ActID"))
subj <- read.table("train/subject_train.txt", col.names=c("Subject"))

base2 <- cbind(x_red, y_tst, subj)

base <- rbind(base1, base2)

# Replace the Activity IDs with Activity Strings

base <- left_join(base, act, by="ActID")
base$ActID <- NULL


# Calculate average Means / STD across all measures by subjects & activities

Activity <- base$Activity
Subject <- base$Subject
MeanIn <- select(.data=base, contains("ean"))
MeanIn <- cbind(MeanIn, Activity, Subject)
MeanRs <- ddply(MeanIn[1:33], c("Subject", "Activity"), colwise(mean))

StdIn <- select(.data=base, contains("std"))
StdIn <- cbind(StdIn, Activity, Subject)
StdRs <- ddply(StdIn[1:33], c("Subject"," Activity"), colwise(mean))


# Join two result sets (Means & STDs) to form final output
# Views & file write optional for debugging purposes

Final <- cbind(StdRs, MeanRs[,3:35])
View(Final)


# write.table(Final, file="GCD_CP1_Part1.txt", row.names=FALSE)
# write.table(colnames(Final), file="GCD_CP1_Par2.txt", col.names=FALSE, row.names = FALSE)
# View(MeanRs)
# View(StdRs)

