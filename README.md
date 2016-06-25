The analysis files include the generated result week4cleaned.txt and run_analysis.R

run_analysis.R contains a run_analysis R function that could extract data from
./data/UCI HAR Dataset/ to generate the week4cleaned.txt.

The scripts workflow:
  1. Extract datasets from the ./data/UCI HAR Dataset
  2. Select the columns of feature variable names that contains "mean" or "std"
  3. Subset the selected columns and assign the descriptive column names to them.
  4. For the y_test/y_train data that extracted, put the descriptive activity name for each corresponding activity code.
  5. Merge X_test, y_test , subject_test to a test_data. Merge X_train, y_train
  , subject_train to a train_data. These dataset contains descriptive variable
  names and activity names.
  6. Bind the test_data and train_data. Then group the observations with activity
    and subject. And apply mean function to these groups. The new tidy data is
    produced.
  7. Output the new tidy data to a txt file.
  8. return the new tidy data as the function output.

week4cleaned.txt could be converted to dataframe by read.table() funciton. Which
contains the mean values for mean and standard deviation values of each measurement
based on each activity and subject.
