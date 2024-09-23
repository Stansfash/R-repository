
X_train_path <- "C:\\Users\\bnnen\\Downloads\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\train\\X_train.txt"
y_train_path <- "C:\\Users\\bnnen\\Downloads\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\train\\y_train.txt"
X_test_path <- "C:\\Users\\bnnen\\Downloads\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\test\\X_test.txt"
y_test_path <- "C:\\Users\\bnnen\\Downloads\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\test\\y_test.txt"
activity_labels_path <- "C:\\Users\\bnnen\\Downloads\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\activity_labels.txt"
features_path <-  "C:\\Users\\bnnen\\Downloads\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\features.txt"
subject_train_path <-  "C:\\Users\\bnnen\\Downloads\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\train\\subject_train.txt"
subject_test_path <-  "C:\\Users\\bnnen\\Downloads\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\test\\subject_test.txt"


X_train <- read.table(X_train_path, header = FALSE)
y_train <- read.table(y_train_path, header = FALSE, col.names = "activity_code")
X_test <- read.table(X_test_path, header = FALSE)
y_test <- read.table(y_test_path, header = FALSE, col.names = "activity_code")
features <- read.table(features_path, header = FALSE, col.names = c("index", "feature_name"))
activity_labels <- read.table(activity_labels_path, header = FALSE, col.names = c("activity_code", "activity_name"))
subject_train <- read.table(subject_train_path, header = FALSE, col.names = "subject")
subject_test <- read.table(subject_test_path, header = FALSE, col.names = "subject")




# Load required libraries
library(dplyr)
library(stringr)

# 1. Load the Inertial Signals Data
# Define folder paths for training and test datasets
train_path <- "C:\\Users\\bnnen\\Downloads\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\train\\Inertial Signals"
test_path <- "C:\\Users\\bnnen\\Downloads\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\test\\Inertial Signals"

# Function to read data from text files
read_inertial_signals <- function(folder_path) {
  file_list <- list.files(path = folder_path, pattern = "\\.txt$", full.names = TRUE)
  for (file in file_list) {
    file_name <- tools::file_path_sans_ext(basename(file))
    data <- read.table(file, header = FALSE)
    assign(file_name, data, envir = .GlobalEnv)
  }
}

# Read training and test datasets
read_inertial_signals(train_path)
read_inertial_signals(test_path)

# 2. Merge Training and Test Sets
# Combine feature measurements, activity labels, and subject IDs
combined_X <- rbind(X_train, X_test)             
combined_y <- rbind(y_train, y_test)             
combined_subject <- rbind(subject_train, subject_test)

# Set column names for the feature data
colnames(combined_X) <- features$feature_name

# Merge the datasets into one
combined_data <- cbind(combined_subject, combined_y, combined_X)

# 3. Extract Measurements on Mean and Standard Deviation
mean_std_features <- grep("mean\\(\\)|std\\(\\)", features$feature_name, value = TRUE)
selected_data <- combined_data[, c("subject", "activity_code", mean_std_features)]

# 4. Add Descriptive Activity Names
final_data <- merge(selected_data, activity_labels, by = "activity_code", all.x = TRUE)
final_data <- final_data[, c("subject", "activity_code", "activity_name", mean_std_features)]

# 5. Appropriately Label the Dataset
names(final_data) <- str_replace_all(names(final_data), 
                                     c("mean\\(\\)" = "Mean",
                                       "std\\(\\)" = "StandardDeviation",
                                       "-mean" = "Mean",
                                       "-std" = "StandardDeviation",
                                       "tBodyAcc" = "TimeBodyAcc",
                                       "tGravityAcc" = "TimeGravityAcc",
                                       "tBodyAccJerk" = "TimeBodyAccJerk",
                                       "tBodyGyro" = "TimeBodyGyro",
                                       "tBodyGyroJerk" = "TimeBodyGyroJerk",
                                       "tBodyAccMag" = "TimeBodyAccMagnitude",
                                       "tGravityAccMag" = "TimeGravityAccMagnitude",
                                       "tBodyAccJerkMag" = "TimeBodyAccJerkMagnitude",
                                       "tBodyGyroMag" = "TimeBodyGyroMagnitude",
                                       "tBodyGyroJerkMag" = "TimeBodyGyroJerkMagnitude",
                                       "fBodyAcc" = "FrequencyBodyAcc",
                                       "fBodyAccJerk" = "FrequencyBodyAccJerk",
                                       "fBodyGyro" = "FrequencyBodyGyro",
                                       "fBodyBodyAccJerkMag" = "FrequencyBodyAccJerkMagnitude",
                                       "fBodyAccMag" = "FrequencyBodyAccMagnitude",
                                       "fBodyGyroMag" = "FrequencyBodyGyroMagnitude",
                                       "fBodyBodyGyroMag" = "FrequencyBodyGyroMagnitude",
                                       "fBodyBodyGyroJerkMag" = "FrequencyBodyGyroJerkMagnitude"
                                     ))

# 6. Create Tidy Dataset with Averages
tidy_average_data <- final_data %>%
  group_by(subject, activity_code, activity_name) %>%
  summarise(across(starts_with("t") | starts_with("f"), mean, na.rm = TRUE)) %>%
  ungroup()

# Save tidy_average_data to a CSV file
write.csv(tidy_average_data, "tidy_average_data.csv", row.names = FALSE)











