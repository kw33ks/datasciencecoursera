# Download data to working directory

download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","./S2_data")
unzip("./S2_data")

library(reshape2)

# Read in test data set

# Read in test data subject # as first column

test_subjects_col1 <- read.table("./UCI HAR Dataset/test/subject_test.txt", sep = " ")

# Read in activity # as second column

test_act_num_col2 <- read.table("./UCI HAR Dataset/test/y_test.txt", sep = " ")

# Create data from with test subject numbers as first column and activity number as second and third columns

test_data <- cbind(test_subjects_col1, test_act_num_col2, test_act_num_col2)

# Create activity lookup table

act_lookup <- data.frame(c(1:6),c("Walking","Walking_upstairs","Walking_downstairs","Sitting","Standing","Laying"))

# Define function to lookup activity numbers against the activity lookup table

g <- function(x){
  act_lookup[x,2]
}

# Replace 3rd column (duplicate of column 2 with activity description) 

test_data[,3] <- sapply(test_data[,3],g)

# Add names to columns 

colnames(test_data) <- c("Volunteer_num","Activity_num","Activity_desc")

# Read in x_test data

x_test <- read.table("./UCI HAR Dataset/test/x_test.txt", sep = "")

# Read in x_test data column descriptions 

desc_data <- read.table("./UCI HAR Dataset/features.txt", sep = " ", colClasses = c("integer","character"))

colnames(x_test) <- desc_data[,2]

test_data <- cbind(test_data, x_test)



# Read in training data set

# Read in test data subject # as first column

train_subjects_col1 <- read.table("./UCI HAR Dataset/train/subject_train.txt", sep = " ")

# Read in activity # as second column

train_act_num_col2 <- read.table("./UCI HAR Dataset/train/y_train.txt", sep = " ")

# Create data from with test subject numbers as first column and activity number as second and third columns

train_data <- cbind(train_subjects_col1, train_act_num_col2, train_act_num_col2)

# Replace 3rd column (duplicate of column 2 with activity description) 

train_data[,3] <- sapply(train_data[,3],g)

# Add names to columns 

colnames(train_data) <- c("Volunteer_num","Activity_num","Activity_desc")

# Read in x_train data

x_train <- read.table("./UCI HAR Dataset/train/x_train.txt", sep = "")

# Add column names

colnames(x_train) <- desc_data[,2]

#Add train_data to x_train

train_data <- cbind(train_data, x_train)


# Bind test and train data

full_data <- rbind(test_data,train_data)

# Create logical vector that identifies the columns relating to mean or std dev

keep_cols <- grep("mean",desc_data[,2])
keep_cols <- append(keep_cols, grep("std",desc_data[,2]))

# Allow for first three columns to be included (Volunteer_num, Activity_num, Activity_desc)

keep_cols <- sapply(keep_cols, function(x){x+3})
full_data <- full_data[,c(1:3,keep_cols)]

# Melt data 

full_data_melt <- melt(full_data, id=c("Volunteer_num","Activity_num","Activity_desc"), measure.vars=colnames(full_data)[4:82])

# Cast data to show averages of all variables by volunteer by activity

full_data_cast <- dcast(full_data_melt, Volunteer_num + Activity_num + Activity_desc ~ variable, mean)

# Change column names to make clear these are now means of variables

names_to_modify <- colnames(full_data_cast)[4:82]
mean_names <- sapply(names_to_modify, function(name) {paste("mean(",name,")",sep="")})
mean_names <- unname(mean_names)

# Combine the names of the first three columns with these new mean names and update our data with them 

updated_names <- c(colnames(full_data_cast)[1:3],mean_names)
names(full_data_cast) <- updated_names

# Write a csv of this tidy data in the working directory

write.table(full_data_cast,file = "./tidydata.txt",sep = " ")
