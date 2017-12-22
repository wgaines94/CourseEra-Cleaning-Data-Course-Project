Codebook

This document should supplement the run_analysis available in this github repo. It will first outline the code process, and then detail the variables used.

CODE PROCESS:
The script will first read in the 6 required files. These are the 'X' 'y' and 'subject' files, for both the train and test datasets. It is assumed that these are in subfolders names 'test' and 'train', as they were provided to students.
The first process, is to column bind the 3 files in each group, to create overall 'test' and 'train' sets, and then to row bind these in to one larger data set, called 'all'.
Next we access the features file, settings Strings As Factors to false for ease, and create an index that only matches the variable names which include 'mean()' and 'std()'. Those with mean in the middle of the name were not included.
These indexes were then all increased by 2, and the numbers 1 and 2 were included at the start of the vector, to account for the 2 columns we had included when merging our data.
The 'allneat' data set was then created, by indexing with this vector, which gave us only the data we desired.

The next step was to rename the activity variables.
A vector was first created which included the names we would replace the numbers with. This was to be used in a loop later.
Nested for loops were then used, to check the activity label against this vector, and replace it with the appropriate string.
It should be noted that attempts to do this directly, without using a second for loop, encountered unexpected problems, and produced lots of NA values.

After the activity labels are renamed, we must create clearer variable names. This was done using the names in the 'features' file as a base point.
Firstly, a full prefix was created for each variable- either 'force- ' or 'time- ', as appropriate, via a for loop.
Repeated grep functions were then used to make the following changes to the variable names:
Remove () following mean and std
Unabbreviate all abbreviations, including std, Mag, Acc and Gyro
Fully list 'x axis' as opposed to '-X', both for clarity and to remove the hyphon
Several variables repeated Body (ie BodyBody), so this was removed
This process introduced some double spacing, so this was removed at the end.

Now all variables were in the same format, and were combined in a vector with 'subject number' and 'activity' as our last two variable names. At this same time, all names were set to entirely lower case.
Finally, these names were assigned to the 'allneat' data frame.

In the final part of the assignment, to me the question was unclear as to exactly what was being asked. Thus i chose to present the data as a table showing, for each variable, the mean for each activity and for each subject, rather than for each subject doing each activity.

This was achieved very simply. First a data frame was created, with the activity names and subject IDs as columns, and variable names as rows. 
Then by way of nested for loops, a mean of each variable was taken for each activity or subject ID.
This required two seperate for loops inside the first, as we had to check across two different variable types.


VARIABLES:
Below, all variables and data used in the script are detailed, in the order they are created in the script.

testdata- the main body of data from the 'test' subset
testsubjects- the list of subject ids from the 'test' subset
testlabels- the activity labels from the 'test' subset
traindata- the main body of data from the 'train' subset
trainsubjects- the list of subject ids from the 'train' subset
trainlabels- the activity labels from the 'train' subset
test- the combination of all three 'test' subset files
train- the combination of all three 'train' subset files
all- the combined data from both subsets
features- the features data provided in the assignment.
index- a vector containing the column numbers (in the features file) of the variables we are interested in
myindex- an adjusted vector that accounts for the variables from the 'subject' and 'labels' data
allneat- the combined data, now subsetted to just the variables we are interested in
labels- a vector containing our replacement names for the activity labels
names- a vector containing the actual names provided in the features file of the variables were are focussing on
names1- a vector that will be used to change these names in to an easier to read format
allnames- a vector containing all the names that we will apply to the 'allneat' dataset
mean- a dataframe that will store all the tidy data, for means of each variable with each subject and activity
