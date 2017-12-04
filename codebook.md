#merging datasets
X_test and X_train files contain aggregated measurements: 563 variables each
Y_test and Y_train files contain information about activities for which the variables have been recorded
subject_test and subject_train files contain information about people for whom these activities have been recorder

Merge of datasets is performed in 2 steps:
1. Create a separate dataset for train and test data. This is done by adding Y and subject columns to X dataset
2. Create a merged dataset containing train and test data.

#Naming columns
Column names are stored in features.txt file they are applied both to the test and train datasets

#Columns selection
Keywords mean and std are not unique, therfore in order to select them we need to search for: "mean()" and "std()" values

#Acticity labels
Activity labels are stored in "activity_labels.txt" once they are obtained, they are applied to the merged dataset using factor
function.

#Creation of a "tidy" dataset
A tidy dataset is created using the aggregate function. Since activity names are not numeric, mean function returns NA for them, therefore
activity labels are excluded from the aggreate function and added later.

#Output
The "tidy" dataset is stored using write.csv function