Codebook for the Tidy Dataset
=
This markdown file presents the codebook for the tidy dataset that is submitted for this assignment to the Coursera website.
Such dataset can be derived by running the run_analysis.R script that can be found in this repository.
This codebook explicitely references data description textfiles (as well as other files) of the original raw data archieve.
You can find the original raw data [here] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
Please refer to the following files for the raw data description:

- README.txt
- feautures_info.txt

This codebook explains only data transformations performed on top of the original dataset as it was.
Moreover, it tackles only specific data transformations applied to distinct variables.
For general data transformations applied to data as a whole please refer to README.md.

This codebook is inspired by [Kirstin's Sample Codebook](https://class.coursera.org/getdata-008/forum/thread?thread_id=34).

## Variables description

#### Subject

- Column 1
- Factor variable with levels 1-30.
- Each level represents one anonymous experiment participant.
- Titled "Subject" because experiment participants are commonly referred to as subjects.
- Inherits its values from "train\subject_train.txt" and "test\subject_test.txt".
- Derives from the raw data without specific transformations.
 
#### Activity

- Column 2
- Factor variable with levels "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING".
- Each level represents one type of activity performed by experiment participants.
- Titled "Activity" as the variable's content suggests.
- Inherits its initial values from "train\y_train.txt" and "test\y_test.txt".
- In the raw data, the factor levels are presented as numbers 1-6. In the tidy data, those are replaced by descriptive level names in accordance with "activity_labels.txt".

#### Feature Measurements

- Columns 3-68
- Numerical variables with values in [-1;1].
- For meanings and units of measurement please refer to the raw data description.
- Titles inherited from "activity_labels.txt". This (1) provides appropriate meaningfulness of the titles (each title describes a type of measurement in a semi-coded manner) and (2) allows using the original raw data descriptions to better understand what each of the columns is.
- Inherits its values from "train\x_train.txt" and "test\x_test.txt".
- In the raw data, there is more than one observation for each type of activity for each subject. In the tidy data, values of each feature variable for one activity of one subject are aggregated by arithmetical averaging.
