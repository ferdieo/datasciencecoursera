The associated file (dataset2.txt) was generated as an exercise prescribed by the Coursera course, "Getting and Cleaning Data".

The source data was obtained (as per course instructions from here):

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The following describe the steps carried out to generate the file: dataset2.txt.

#1. Copy these files:
#C:\Users\Ferdie\Desktop\R\getdata-projectfiles-UCI HAR Dataset\UCI HAR Dataset\train\subject_train.txt
#C:\Users\Ferdie\Desktop\R\getdata-projectfiles-UCI HAR Dataset\UCI HAR Dataset\train\X_train.txt
#C:\Users\Ferdie\Desktop\R\getdata-projectfiles-UCI HAR Dataset\UCI HAR Dataset\train\y_train.txt
#C:\Users\Ferdie\Desktop\R\getdata-projectfiles-UCI HAR Dataset\UCI HAR Dataset\test\subject_test.txt
#C:\Users\Ferdie\Desktop\R\getdata-projectfiles-UCI HAR Dataset\UCI HAR Dataset\test\X_test.txt
#C:\Users\Ferdie\Desktop\R\getdata-projectfiles-UCI HAR Dataset\UCI HAR Dataset\test\y_test.txt
#...to single location to read into r.


#2. Read all files into R
#3. Give each table a column with row_id for merging tables
#4. Install and load plyr
#5. Merge the three test tables
#6. Drop the row_id column
#7. Merge the three test tables
#8. Drop the row_id column
#9. Union the two datasets test and train
#10. Apply column names
#11. Load dplyr
#12. Convert to dplyr data table
#13. Get std, mean columns with activity and subject
#14. Rename columns in activity_labels for join
#15. Join to get nice names for activities
#16. Remove activity code column
#17. Replaced name column with activity (i.e. change column name)
#18 Reorder columns, bring activity and subject to front
#19. Make nicer column names
#20. Apply column names
#21. Create second summarised data set
#22. Create column names
#23. Apply column names
