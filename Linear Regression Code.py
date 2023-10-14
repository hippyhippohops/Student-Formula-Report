import numpy as np
import sklearn.ensemble
from scipy import sparse
import matplotlib.pyplot as plt
import pandas as pd
from IPython.display import display
import mglearn
from matplotlib.pyplot import subplots
import statsmodels.api as sm
from statsmodels.stats.outliers_influence import variance_inflation_factor as VIF
from statsmodels.stats.anova import anova_lm
from ISLP import load_data
from ISLP.models import (ModelSpec as MS, summarize, poly)
from sklearn import linear_model
import numpy as np
import matplotlib.pyplot as plt  # To visualize
import pandas as pd  # To read data
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split

def main():
    #Skip rows allows me to skip the first 2 rows which contains the column title and the units. This avoids a column dtype error
    df = pd.read_csv(r'/Users/aravinthkrishnan/Desktop/FSAE.csv', skiprows=[0,1])
    #print(df)
    #This tells us that each column has entries of type float64
    #print(df.dtypes)
    #I do this to check that every column here has the same data type. So there is no string, all of them are numbers
    #print(df.info())
    #This helps me check is any column contains null values. We find out that the first column has a null value. So let's remove that.
    #print(df.isna().any())
    #print(df.iloc[0])
    #x = df.iloc[0]
    #print(x.isna().any())
    #print(df.columns)

    """Now we want to do simple regression and multlinear regression on the columns of the df"""
    df = pd.read_csv(r'/Users/aravinthkrishnan/Desktop/FSAE.csv')
    #print(df.columns)
    columns_I_want = ['Vehicle Speed','Damper Pos FL', 'Damper Pos FR', 'Damper Pos RL', 'Damper Pos RR']
    df_shock_pod = df[columns_I_want]
    #print(df_shock_pod)
    #Now I want to remove the first 2 rows and last rows (row 77501) to remove NaN value
    df_shock_pod = df_shock_pod.dropna()
    df_shock_pod = df_shock_pod.drop(0)
    #print(df_shock_pod)

    """Now we will perform simple pairwise linear regression on the columns given"""
    for i in range(1,5):
        X = df_shock_pod.iloc[:, i].values.reshape(-1, 1)
        #print(X)
        y = df_shock_pod.iloc[:, 0].values.reshape(-1, 1)
        #print(y)
        X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.25, random_state=0)
        Im = LinearRegression().fit(X_train,y_train)
        #Get intercept
        y_intercept = Im.intercept_
        #print(Im.intercept_)
        #Get coefficients
        coefficient = Im.coef_
        #print(Im.coef_)
        print("The Linear equation is: velocity = %d %d + %d ", coefficient, df_shock_pod.columns[i], y_intercept)

    #Do multiple linear regression
    # Set independent and dependent variables

    X = df_shock_pod[['Damper Pos FL', 'Damper Pos FR', 'Damper Pos RL', 'Damper Pos RR']]
    y = df_shock_pod['Vehicle Speed']
    #print(X)
    #print(y)

    # Initialize model from sklearn and fit it into our data
    regr = linear_model.LinearRegression()
    model = regr.fit(X, y)

    print('Intercept:', model.intercept_)
    print('Coefficients:', model.coef_)










main()
