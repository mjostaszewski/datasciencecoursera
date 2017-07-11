source("data_load.R")

# The function responsible for consolodation of the raw datasets loaded from files.
# It labels the measurements, prunes them according to the requested pattern, labels the activities 
# and joins three separate datasets: subjects, activities and measurements into one.
label_and_prune <- function(raw_dataset, prune_by = c("-mean\\(\\)","-std\\(\\)")) {
  named_measurements <- raw_dataset$measurements
  # Assign labels to measurements
  names(named_measurements) <- raw_dataset$feature_labels[,2]
  # Prune measurements by required parameters
  prune_regexp <- paste(prune_by, collapse = "|")
  named_measurements <- named_measurements[,grep(prune_regexp, raw_dataset$feature_labels[,2])]
  
  # Use named activities instead their numeric version
  named_activities <- sapply(raw_dataset$activities, function(x) raw_dataset$activity_labels[x,2])
  
  # Create a fata frame with subjects, named activities and named measurements
  return(data.frame(subject_id = raw_dataset$subjects[,1], 
                    activity_name = named_activities[,1], 
                    named_measurements, stringsAsFactors = FALSE))
}

# Load the raw datasets using the dedicated loading function (see data_load.R)
training_set <- load_by_type("train")
testing_set <- load_by_type("test")

# Labeling-and-pruning results are supplied with a column for the dataset type (train or test) and merged.
# Because they have the same structure, we can use rbind directly
tidy_set = rbind(cbind(label_and_prune(training_set), source_dataset_type = "train", stringsAsFactors = FALSE),
                 cbind(label_and_prune(testing_set), source_dataset_type = "test", stringsAsFactors = FALSE))

write.table(tidy_set, file = "tidy_dataset.txt", sep = "\t", row.names = F, col.names = T, quote = F)

# Loading to 'dplyr' structure 'tbl'
library(dplyr)
tidy_tbl <- tbl_df(tidy_set)
other_tidy_tbl <- (tidy_tbl %>% select(-source_dataset_type) %>% group_by(subject_id, activity_name) %>% summarise_all(mean))
write.table(other_tidy_tbl, file = "other_tidy_dataset.txt", sep = "\t", row.names = F, col.names = T, quote = F)