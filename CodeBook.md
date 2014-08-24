
One data set is created by merging the training and test data sets.
In specific, X_test.txt, y_test.txt, subject_test.txt in the test directory are merged into one test data table. 
Similarly, X_train.txt, y_train.txt, subject_train.txt in the train directory are merged into one training data table.
The indices related to means and standard deviations are selected from features.txt.
Only the measurements on the mean and standard deviation for each sample are extracted from the training and test data, which then are combined into a single set.
A data set is created to have the average of variables related to the activity and subject. 
The rows are reorganized so that the activities from a subject are positioned in adjacent rows.
Each activity label is finalized by replacing the corresponding activity name.
