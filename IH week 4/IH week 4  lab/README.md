# Ironhack Lab
### by Cath Vos, May 2021

![image](https://user-images.githubusercontent.com/101712996/166712789-1956a202-8ecf-43ea-b67a-288461c88c3d.png)




# Imbalanced data lab - Build a churn predictor 

## Table of content
- Project Brief
- Data
- Process & Tools
- Key Take Aways

### Project Brief

#### Scenario:
We are given data from 7000 telecom customers and we want to work out how we can best predict the churn rate based on the data set provided.

#### Challenge:
Use the given data set to build a churn predictor.

#### Problem:
Customers stay, customers go, we want to figure out how we can predict the churn rate, the main problem is that the dataset is quite inbalanced, we´ll explore different methods to balance the data to see which one is most reliable and what the differences between them are.

Original data set

![confusion matrix 1](https://user-images.githubusercontent.com/101712996/166720276-30b0dcbd-9e6c-480a-b471-07e8d9a9eb27.png)

SMOTE

![confusion matrix smote](https://user-images.githubusercontent.com/101712996/166720296-efa827bc-4a31-458b-9852-64a34440605b.png)

TOMEK

![confusion matrix tomek](https://user-images.githubusercontent.com/101712996/166720338-d6230737-7cd7-4bd2-b01c-fb12546d4899.png)

### Data
Leveraging on the data we were provided with, we used and Python's data visualisation tools to explore the differences between different methods to balance the data.


For further details on all features, please refer to the notebook.

### Process & Tools
#### Process
1. Loaded the dataset and explored the variables.
2. Tried to predict variable Churn using a logistic regression on variables tenure, SeniorCitizen,MonthlyCharges.
3. Extracted the target variable.
4. Extracted the independent variables and scaled them.
5. Build the logistic regression model.
6. Evaluated the model.
8. Applied imblearn.over_sampling.SMOTE to the dataset. Build and evaluated the logistic regression model.
9. Applied imblearn.under_sampling.TomekLinks to the dataset. Build and evaluated the logistic regression model.

#### Workflow
Github: set up a folder on Cathclass Github repo.
Data cleaning & wrangling in Python: drop 'customerID' column, check for null values, convert float columns to int.
Prepocessing: 3 methods - SMOTE and TOMEK
Machine Learning Model: using scikit learn

- iteration 1: preprocessing and encoding numerical features to categorical ones

- iteration 2: build the logistic regression model and run it based on the original date

- iteration 3: executed SMOTE sampling to run the logistic regression model again

- iteration 4: executed TOMEK sampling to run the logistic regression model once more

#### Tools

Database: customer_churn.csv
Vizualizations: Sklearn
Code: Jupyter Notebook

### Key Take Aways

1. There are different methods to handle imbalanced data. 





Thank you for reading!

If you have any questions, please reach out!

Cath
