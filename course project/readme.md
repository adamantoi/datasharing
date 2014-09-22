## Analyse Samsung's Wearable Experiment Data
This script creates a tidy data from a Samsung experimental data on user activity wearing a Samsung Galaxy S smartphone (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
The data produced gives information about averaged value of mean() and std() for each selected variables based on unique user and activity

## Steps 
- The script assume you put your .txt files in "./data" directory of your working directory
- Read all the _test.txt and _train.txt files into R objects
- Merge both test and train data into one data frame(data, subject, and activity)
- Select variables contain mean() and std()
- Rename columns/variables' names for better reading (activity, subject, and other 66 names filtered from previous process)
- Transform activity's value into readable value ("walking", "walkingUpstairs", "walkingDownstairs", "sitting", "standing", "laying")
- Change subject and activity into factors
- Calculate average value for each variable based on subject and activity using the aggregate function
- Write the output to a file using write.table function with row.names property set to false.
