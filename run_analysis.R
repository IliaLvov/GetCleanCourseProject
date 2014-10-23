# ---- Run_analysis.R ----

# A script file required for the Course Project in the "Getting and Cleaning Data" module.
# Created by Ilia Lvov.

# ---- Downloading data ----

# This is by far the longest part of the script to be executed.
# Hence, while testing, for the sake of convinience I made it executable only if it hadn't been before.
# However, it is more reliable to make it executable every time.
# Otherwise, if someone changes the downloaded data files it goes unpunished by the script.
# So I commented the IF-condition to make it unconditionally executable.
# However, whoever uses this script can easily return it back by de-commenting.
# if(!file.exists("UCI HAR Dataset")) { # Checking existence of the directory where this project's data will be stored in.
      data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      download.file(data_url, destfile = "uncommon_filename.zip", method = "curl") # Non-MAC users may require a different method,
      unzip("uncommon_filename.zip")
      download_date <- date()
      data_download_info <- data.frame(downloaded_on = download_date, dowloaded_from = data_url)
      # Now all the download-related info is stored as a data frame.
      # We can write it to a separate file to keep forever.
      # And aslo we can clean R memory from intermediaries.
      write.table(data_download_info, "UCI_HAR_data_download_info.csv", sep=",", row.names = FALSE)
      # Comma-separation to avoid bugs with tabs in dates().
      remove(data_url)
      remove(download_date)
      # As the ZIP-archieve is already unziped, it can also be removed.
      file.remove("uncommon_filename.zip")
# }

# ---- Importing and merging data ----

# This part of the script is taking the longest time to execute (apart from downloading data).
# Hence the same logic applied to IF-conditioning and commenting.
# if(!exists("long_data")) { # Checking is the data is already imported and merged.
      train_subj <- read.table("UCI HAR Dataset/train/subject_train.txt", colClasses = "factor")
      train_act <- read.table("UCI HAR Dataset/train/y_train.txt", colClasses = "factor")
      train_resp <- read.table("UCI HAR Dataset/train/X_train.txt", colClasses = "numeric")
      test_subj <- read.table("UCI HAR Dataset/test/subject_test.txt", colClasses = "factor")
      test_act <- read.table("UCI HAR Dataset/test/y_test.txt", colClasses = "factor")
      test_resp <- read.table("UCI HAR Dataset/test/X_test.txt", colClasses = "numeric")
      # Now that the data is imported, it should be merged.
      train_data <- cbind(train_subj, train_act, train_resp)
      test_data <- cbind(test_subj, test_act, test_resp)
      long_data <- rbind(train_data, test_data)
      # Now the whole data is merged into long_data and we can remove intermediaries from the memory.
      remove(train_subj)
      remove(train_act)
      remove(train_resp)
      remove(test_subj)
      remove(test_act)
      remove(test_resp)
      remove(train_data)
      remove(test_data)
# }

# ---- Adding column names ----

# First trivial names are given.
colnames(long_data)[1] = "Subject"
colnames(long_data)[2] = "Activity"
# Now we need to name response columns.
# For that we need to read them from features.txt, and then assign the values.
resp_names <- read.table("UCI HAR Dataset/features.txt", colClasses = "character")
resp_names <- resp_names[ ,2]
for (i in 1:length(resp_names)) {
      colnames(long_data)[i+2] <- resp_names[i]
}
remove(resp_names)

# ---- Subsetting mean and SD columns ----

short_data <- long_data[ , c(1,2)] # Trivial columns added.
# Now adding those columns that are either means or SDs.
# Means have "-mean" in their colnames, SDs have "-std".
# There are also variables that have "-meanFreq" in their colnames.
# Those are excluded, as they do not represent means for the measurments themselves.
# grepl() function is used to identify substrings.
for (i in 3:ncol(long_data)) {
      c_name <- colnames(long_data)[i]
      if (((grepl("-mean", c_name)) && !(grepl("-meanFreq", c_name))) || (grepl("std", c_name))) {
            c <- as.data.frame(long_data[ ,i]) # Extracting the right column.
            # The colums loses its name while exctracting. We will return it!
            colnames(c)[1] <- c_name
            # Now adding the column to the short dataset.
            short_data <- cbind(short_data, c)
      }
}
# Cleaning memory from intermediary stuff.
remove(c_name)
remove(i)
remove(c)

# ---- Showing proper activity names ----

# Reading data on the activity names.
activity_names <- read.table("UCI HAR Dataset/activity_labels.txt", colClasses = "character")
activity_names <- activity_names[ ,2] # The names themselves appear to be in the second column.
# The data is already sorted, no sorting job required.
levels(short_data[ ,2]) <- activity_names # Assigning proper activity names to the levels.
remove(activity_names) # Removing the intermediary.

# ---- Creating tidy dataset of averages ----

# We need to calculate means for subsets. Hence, melt-dcast logic seems to fit.
# First we need to load an appropriate package: reshape2
library("reshape2") # use install.packages("reshape2") if the package not found
# This packages containts a function to melt data that are useful to distinguish between IDs and measurements.
melted_data <- melt(short_data, id = colnames(short_data)[c(1,2)], measure.vars = colnames(short_data)[-c(1,2)])
# Now call dcast with a function mean to summarize measurements for every pair of ID levels.
tidy_data <- dcast(melted_data, Subject + Activity ~ variable, mean)
# Finally, removing the intermediary.
remove(melted_data)

# ---- Writing data to a file ----

# So far we have 3 versions of the dataset in memory.
# The first one is long_data. It has all the variables and all the cases.
# The second one is short_data. It has all the cases, but only those response variables that are on means and SDs.
# The last one is tidy_data. It has the same variables as short_data, and they are aggregated by subject/action.
# The following code writes tidy_data to a file, as the assignment requires.
# However, it can be easily modified to write other versions of the dataset if they are needed.
write.table(tidy_data, file="tidy_data.txt", row.names = FALSE)
