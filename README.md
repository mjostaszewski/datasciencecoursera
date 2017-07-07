#Scripts for tyding the "Human Activity Recognition Using Smartphones Data Set"

##data\_load.R

This script loads either "train" or "test" dataset from the "Human Activity Recognition Using Smartphones Data Set" (source dataset).
It creates a list with the subject id (subject\_\*.txt), measurements (X\_\*.txt) and activity codes (y\_\*.txt) from either "UCI HAR Dataset/train" or "UCI HAR Dataset/test". Measurements are already parsed via the read.fwf function into numerical values.  
The list also contains labels from the "UCI HAR Dataset/features.txt" (for features) and from the "UCI HAR Dataset/activity_labels.txt" (for activity names).

The function in the script will create cache of loaded files in Rdata directory (created if not existing).

Finally, the script will download and unpack the "UCI HAR Dataset" in the current directory, if this directory does not exist.

##run\_analyze.R

This is the script to be executed in order to tidy up the source dataset.  
This script uses the loaded datasets to consolidate them and merge them into a single dataset.  
By default it should be executed in the directory, where the "UCI HAR Dataset" directory is, not from inside of it. Please, note, that "data\_load.R" takes care of this.

The consolidated dataset is saved to a tab-separated text file.

Then, the script creates other tidy dataset, by taking the tidy dataset and applying group\_by and summarize\_all of 'dplyr' to calculate mean for all variables for each subject id and each activity name.
