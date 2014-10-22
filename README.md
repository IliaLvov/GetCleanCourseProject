Getting and Cleaning Data Course Project Submission
=====================
This is a repo for a submission for the "Getting and Cleaning Data" Coursera module course project by Ilia Lvov. The submission constitutes the following:
- A tidy dataset available via Coursera website;
- A repo (you are currently viewing) that contains (a) an R-script file Run_analysis.R that creates the tidy dataset and writes it to a textfile, (b) a README.md textfile (you are currently reading) that explains the basic principles behind the code and overall data transformations and (c) a CodeBook.md textfile that describes the variables in the tidy dataset.

## Analysis description

The analysis is performed by the Run_analysis.R script file. The script is divided in several logical parts by the aids of in-line comments. The comments in the R-file should give a good overview of how it works, however some more detailed discussion of each code part is provided below.

N.B. In each of its parts, the code sometimes creates R objects that are of no use beyond the limits of this part. In this case, the code automatically removes those objects from the memory at the end of the part. Respective operations of the code will not be discussed below every time; however, you can trace them by reading comments in the R-script file.

#### Downloading data

First the code downloads the zip-archieve with the raw data to a working directory. The local copy of the archieve is given a name of "uncommon_name.zip" in an attemp to prevent possible clashes with other archieves stored on a user's machine. Please note that the download method is "curl", however you may need to change depending on your OS (please refer to Coursera lectures for further guidance).

Then the code unzips the downloaded archieve into the working directory. As the archieve will not be used anymore, it is subsequently deleted by the code.

Next the code stores parametres of the downnload (URL and date) into a data frame "dowload_data_info", as well as in a "UCI_HAR_data_download_info.csv" file in the working directory.

####
