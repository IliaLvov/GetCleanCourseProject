Getting and Cleaning Data Course Project Submission
=====================
This is a repo for a submission for the "Getting and Cleaning Data" Coursera module course project by Ilia Lvov. The submission constitutes the following:
- A tidy dataset available via Coursera website;
- A repo (you are currently viewing) that contains (a) an R-script file Run_analysis.R that creates the tidy dataset and writes it to a textfile, (b) a README.md textfile (you are currently reading) that explains the basic principles behind the code and overall data transformations and (c) a CodeBook.md textfile that describes the variables in the tidy dataset.

## Analysis description

The analysis is performed by the Run_analysis.R script file. The script is divided in several logical parts by the aids of in-line comments. The comments in the R-file should give a good overview of how it works, however some more detailed discussion of each code part is provided below.

N.B. In each of its parts, the code sometimes creates R objects that are of no use beyond the limits of this part. In this case, the code automatically removes those objects from the memory at the end of the part. Respective operations of the code will not be discussed below every time; however, you can trace them by reading comments in the R-script file.

#### Downloading data

In this part, the code downloads the raw data into local files.

First the code downloads the zip-archieve with the raw data to a working directory. The local copy of the archieve is given a name of "uncommon_name.zip" in an attemp to prevent possible clashes with other archieves stored on a user's machine. Please note that the download method is "curl", however you may need to change depending on your OS (please refer to Coursera lectures for further guidance).

Then the code unzips the downloaded archieve into the working directory. As the archieve will not be used anymore, it is subsequently deleted by the code.

Next the code stores parametres of the downnload (URL and date) into a data frame "dowload_data_info", as well as in a "UCI_HAR_data_download_info.csv" file in the working directory.

#### Importing and merging data

In this part, the code creates a big data frame "long_data" that includes unaggregated data on all types of measurements.

First, the code reads and merges the training data. For that it reads in data on subjects from "subject_train.txt", activities from "y_train.txt" and response measurements from "x_train.txt" into separate data frames. As each of the three data frames contains various variables on the same observations, they are subsequently merged column-wise.

Then, the code performs the same job for the test data. Hence, it gets two data frames: one for the training data, the other for the test one. Those data frames contain the same variables for different observations, thus they are subsequently merged row-wise. The result of this merge is the "long_data" data frame.

#### Adding column names

In this part, the code changes the names of the columns from meaningless ("v1", "v2", ...) to meaningful ("Subject", "Activity", names of measurements).

First, it "manually" assignes the names to the first to columns.

Then it reads the file "features.txt" that has too columns: a count of the measurements and the measurements names. From the second column, the code creates a vector of measurement names, and then it assignes those names to the data columns one by one.

#### Subsetting mean and SD columns

In this part, the code creates a data frame "short_data" that contains only the measurements of means and standard deviations.

First, it creates "short_data" as a data frame with the first two columns of "long_data", as Subject and Activity are ID- rather than measurement columns and thus should not be ommitted.

Then, the code adds one-by-one those columns of "long_data" that contain "-mean()" or "-std()" in their titles to "short_data". In the author's opinion, other columns (like those on meanFreq()) are on means of metadata rather then on means of the measurements themselves and hence should be ommitted.
