Getting and Cleaning Data Course Project
========================================

**Author:** Marek Ostaszewski

**Date:** 06/07/2017

The document describes two datasets required for the course project of the 'Getting and Cleaning Data' course.
It is a transformed dataset, originally from:

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

Human Activity Recognition Using Smartphones Dataset  
Version 1.0  
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.  
Smartlab - Non Linear Complex Systems Laboratory  
DITEN - Universit‡ degli Studi di Genova.  
Via Opera Pia 11A, I-16145, Genoa, Italy.  
activityrecognition@smartlab.ws  
[www.smartlab.ws](www.smartlab.ws)  

#Dataset description
__Disclaimer: the dataset description draws heavily from the original dataset description (features.txt and README.txt), see the link above.__

The dataset contains measurements taken from 30 subjects performing 6 different activities (walking, walking upstairs, walking downstairs, sitting, standing, laying).
They measurements were taken with a smartphone (Samsung Galaxy S II), which subjects were wearing on their waist.

## Variable description

* **subject\_id:** an identifier of the subject participating in the study
* **activity\_name:** the name of the activity performed by the user
* **Measurements**: the measurements come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). These signals were used to estimate variables of the feature vector for each pattern ('-XYZ' is used to denote 3-axial signals in the X, Y and Z directions).  
  **For each of the measurement, *mean* and *standard deviation* values are available as variables (see 'Dataset transformations' below)**.
  * **tBodyAcc-XYZ**
  * **tGravityAcc-XYZ**
  * **tBodyAccJerk-XYZ**
  * **tBodyGyro-XYZ**
  * **tBodyGyroJerk-XYZ**
  * **tBodyAccMag**
  * **tGravityAccMag**
  * **tBodyAccJerkMag**
  * **tBodyGyroMag**
  * **tBodyGyroJerkMag**
  * **fBodyAcc-XYZ**
  * **fBodyAccJerk-XYZ**
  * **fBodyGyro-XYZ**
  * **fBodyAccMag**
  * **fBodyAccJerkMag**
  * **fBodyGyroMag**
  * **fBodyGyroJerkMag**
* **source\_dataset\_type:** because the original dataset was split into training and testing sets, this column was provided to indicate the original separation.
  
## Dataset transformations

### **Tidy** dataset

Tidy dataset was constructed from the original data as follows.  
1. From both "UCI HAR Dataset/train" and "UCI HAR Dataset/test" subdirectories, files subject\_train.txt, X\_\*.txt and y\_\*.txt were read (where \* is either "train" or "test"). Here, X\_\*.txt is a fixed width file, with column width of 16 characters, other files are one-colum tables.  
2. File "UCI HAR Dataset/activity_labels" was used to resolve activity code into **activity\_name** variable.  
3. File "UCI HAR Dataset/features.txt" was used to set variable names in the table from X\_\*.txt.  
4. Columns from the table from X\_\*.txt (see **Measurements** above) were restricted to mean and std.  
5. All three data sources (subject id, activity name and measurements) were combined into a single table, one for "train" and "test" subdirectories.  
6. A variable "source\_dataset\_type" was added to "train" and "test" tables to reflect data origin.  
7. The "train" and "test" tables were combined into a single dataset and saved to a text, tab-separated file.

### **Other tidy** dataset

Other tidy dataset was constructed from the "Tidy dataset" as follows, using "dplyr" functionalities.  
1. The variable "source\_dataset\_type" was removed.  
2. A grouping was created by "subject\_id" and "activity\_name".  
3. Mean for all non-grouped variables was calculated.  
4. The resulting dataset was saved to a text, tab-separated file.
