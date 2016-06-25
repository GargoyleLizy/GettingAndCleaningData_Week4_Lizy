library(dplyr)

run_analysis <- function(){
    features_path <- "./UCI HAR Dataset/features.txt"
    X_train_path <- "./UCI HAR Dataset/train/X_train.txt"
    subject_train_path <- "./UCI HAR Dataset/train/subject_train.txt"
    y_train_path <- "./UCI HAR Dataset/train/y_train.txt"
    
    X_test_path <- "./UCI HAR Dataset/test/X_test.txt"
    subject_test_path <- "./UCI HAR Dataset/test/subject_test.txt"
    y_test_path <- "./UCI HAR Dataset/test/y_test.txt"
    raw_list_data <- extractData(features_path, X_train_path, y_train_path, subject_train_path
                                 ,X_test_path, y_test_path, subject_test_path)
    ## get all the data
    features <- raw_list_data[[1]]
    X_train <- raw_list_data[[2]]
    y_train <- raw_list_data[[3]]
    subject_train <- raw_list_data[[4]]
    X_test <- raw_list_data[[5]]
    y_test <- raw_list_data[[6]]
    subject_test <- raw_list_data[[7]]
    
    ## select the columns of mean and std
    selected_cols <- grep(".*mean|std.*", features[,2])
    selected_cols_names <- features[selected_cols,2]
    selected_X_test <- X_test[,selected_cols]
    selected_X_train <- X_train[,selected_cols]
    
    ## put descriptive variables names for the variables
    colnames(selected_X_test) <- selected_cols_names
    colnames(selected_X_train) <- selected_cols_names
    
    ## put descriptive activity names for the activities.
    activity_label_path <- "./UCI HAR Dataset/activity_labels.txt"
    activity_labels_df <- read.table(activity_label_path)
    activity_labels_c <- activity_labels_df[,2]
    y_test$activity <- activity_labels_c[y_test[,1]]
    y_train$activity <- activity_labels_c[y_train[,1]]
    
    ## put test/ train data sets together
    test_data <- mutate(selected_X_test, subject = subject_test[,1], activity = y_test$activity)
    train_data <- mutate(selected_X_train, subject = subject_train[,1], activity = y_train$activity)
    
    ## all the variables are ready in workspace here.
    # group by activity and subject
    grp_cols <- c("activity","subject")
    dots <- lapply(grp_cols,as.symbol)
    
    # combine all data and then produce the new tidy data.
    all_data <- rbind(test_data,train_data)
    cleaned_data %>%
        group_by_(.dots = dots) %>%
        summarise_each(funs(mean))
    # export the cleaned data
    write.table(cleaned_data, file="./week4cleandata.txt",row.names = FALSE )
    # return the cleaned data
    cleaned_data
}

extractData <- function(features_path, X_train_path, y_train_path, subject_train_path,
                        X_test_path, y_test_path, subject_test_path){
    features<- read.table(features_path)
    
    X_train <- read.table(X_train_path)
    subject_train <- read.table(subject_train_path)
    y_train <- read.table(y_train_path)
    
    X_test <- read.table(X_test_path)
    subject_test <- read.table(subject_test_path)
    y_test <- read.table(y_test_path)
    
    list(features, X_train, subject_train, y_train, X_test, subject_test, y_test)
}
