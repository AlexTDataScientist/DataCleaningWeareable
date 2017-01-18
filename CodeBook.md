# Code Book

Please unzip the UCI HAR Dataset and place the run_analysis.R file on the same level as ./test and ./train subforlders

The X_train.txt, X_test.txt files contain the measurements, 561 columns in each file
The features.txt file has 561 features matching columns above
Subject*.txt files contain who had the sensors for each row of measurements
Activity_labels.txt contains the labels for 6 activities
The y_*.txt contain what activity_id the subject was doing


The code will load each file category, concatenate test and training.
Will join the activity numeric id with it's description
Will add the features as column names.
Will keep only the mean() an std() named columns

Will write to text file
Will aggregate all mean* and std* columns by subject and activity


## The x_y_s_a.txt file
The first three columns are subject, folder, activity, where the first and third come from the original data.
There is one extra column added for "test" or "training" origin of the data.
The rest columns have the same description as the original data, see features.txt and features_info.txt

## The aggregates.txt file

All numeric columns are aggregated by Subject and activity





