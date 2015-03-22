This is the documentation of the Project within the course: Practical Machine Learning
Author: Micha³ Mi³kowski
Date: 22.03.2015        

Data: https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv
Data for prediction: https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv

Coming from the source:  http://groupware.les.inf.puc-rio.br/har


1. The goal of the project was to predict the manner in which people did the exercise. 
This is the "classe" variable in the training set. 

2. Pre-processing of the data

The data set consisted of 160 variables. Most of them were missing for the vast majority of observations. 
Among around 19k observation only about 500 observations had no missing values in the majority of features. 
All of them where characterized by the feature: new_window="yes". 
Due to the fact that all the observations for prediction had the value new_window="no" I limited the dataset to observations with new_window="no".
In the next step I got rid of all the columns with more then 99% of missing values.
I excluded also manually feature new_window which had only one distinct value.
Further I divided the dataset into training (70%) and testing(30%).

3. The way of building model:
I chose random forest because this method is credited with a great performance for classification tasks. It deals also with all types of variables and missing values.

4. Cross validation:
I used 10-fold cross validation. Additionally to the bagging implemented in random forest algorithm that should give a great reduction of variance.

5. Expected out of sample error:
0.09% estimated on cross validation test sets
0.05% estimated on test set

     