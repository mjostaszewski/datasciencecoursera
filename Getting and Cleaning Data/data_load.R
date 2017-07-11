# A small convenience function for %l%inking series of strings
"%l%" <- function(a,b) paste0(a,b)

# Load all the files for the dataset by type - either 'train' or 'test'
# File structure is the same.
# The function is caching of the result to an R file, reducing the reload time - if needed.
# The function returns the raw, unformatted versions of the tables
# Parameters:
# type - 'train' or 'test', defines which dataset will be loaded
# force_reload - logical, may force data load and save to cache
# path - a path to the location of "UCI HAR Dataset", unzipped
load_by_type <- function(type = c("train","test"), force_reload = F) {
  # Create location for cache files
  if(!dir.exists("Rdata")) { dir.create("Rdata") }
  
  if(!file.exists("./Rdata/" %l% type %l% "_cache.Rd") || force_reload) {
    # Load the invariants - activity and feature labels
    activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header = F, stringsAsFactors = F)
    feature_labels <- read.table("./UCI HAR Dataset/features.txt", header = F, stringsAsFactors = F)
    
    # Train or test dataset loaded here, depending on the 'type'
    subjects <- read.table("./UCI HAR Dataset/" %l% type %l% "/subject_" %l% type %l% ".txt")
    
    message("Reading in a large (561 columns) fixed width table... this may take a while...")
    # Here we deal with a fixed width table of 561 columns (one per feature), each 16 chacacters long
    measurements <- read.fwf("./UCI HAR Dataset/" %l% type %l% "/X_" %l% type %l% ".txt", widths = rep(16,561))
    message("Done.")
    
    activities <- read.table("./UCI HAR Dataset/" %l% type %l% "/y_" %l% type %l% ".txt")
    # Create the object named accordingly to 'type'
    assign(type %l% "_raw", list(subjects = subjects,
                                measurements = measurements, 
                                activities = activities,
                                activity_labels = activity_labels,
                                feature_labels = feature_labels))
    
    message("Writing to cache...")
    # 'list' allows to parametrize saved objects, here by 'type'
    save(list = type %l% "_raw", file = "./Rdata/" %l% type %l% "_cache.Rd")
    message("Done.")
  } else {
    message("Loading from cache...")
    load(file = "./Rdata/" %l% type %l% "_cache.Rd")
    message("Done.")
  }
  ### Return the list named depending on the type
  return(eval(parse(text = type %l% "_raw")))
}

if(!dir.exists("UCI HAR Dataset")) {
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "source.zip")
  unzip("source.zip")
}