import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import statsmodels.api as sm
import scipy.stats as scistat
from sklearn.preprocessing import StandardScaler
from sklearn.ensemble import IsolationForest
from mpl_toolkits.mplot3d import Axes3D






def main():
    #Import Bengal CSV Data as a data frame.

    """
    The read_csv method of pandas library can be used to read a file with comma separated values (CSV) and load it into
    memory as a pandas dataframe.
    """

    df = pd.read_csv(r'/Users/aravinthkrishnan/Desktop/FSAE.csv')
    #print(df)

    """
    The pandas read_csv method will make an educated guess about the data type of each column, but you will need to help
    it along to ensure that these guesses are on the mark. And we would also want to check the data type of each column 
    to understand the data better.
    """
    #print(df.dtypes)

    """ Originally, I didn't skip any rows. But when I didn't, the first row consisted of the units of each column.
    This made the data type of each column of type object. To make my columns of type integer or float, I skipped the
    row indexed 1. Now, every row is of type float64."""

    df = pd.read_csv(r'/Users/aravinthkrishnan/Desktop/FSAE.csv',skiprows=[1])
    #print(df)
    #print(df.dtypes)

    # First we identify the columns to loop through the columns later on
    df.columns = df.columns.str.replace(' ', '')  # WHAT DOES STR COMMAND DO, FIGURE OUT THE PURPOSE OF THIS COMMAND
    columns_of_df = df.columns
    # print(columns_of_df) #Just to see how this .columns method works

    """
    Now, let's get a quick glimpse of the data by viewing the summary statistics for each column
    """
    for i in columns_of_df:
        #print(i) #This is to ensure I pick out the column names
        #print(df[i].describe())
        pass #This is just here to ensure the code runs after commenting out everything above
    #FIGURE OUT HOW TO STORE THIS IN AN EXCEL OR CSV FILE, SO ESSENTIALLY FIND A WAY TO EXTRACT VALUES


    """Now, we want to look for missing values in each column. So, we use the isnull command which returns True for each 
    value that is missing for each column, and False for when it is not missing. We then chain this with sum to count the 
    missings for each column. Remember that when working with Boolean values, sum treats True as 1 and False as 0."""

    #print(df.isnull().sum()) #READ UP ON WHAT THE COMMAND DOES, WHY DOES NOT SPECIFYING AXIS LEAD TO COLUMN SUM

    """After running print(df.isnull().sum()), it seems like every column other than the time column has value 1. So, every
    column, other than the time column has missing entries. So, now we need to iterate through the columns to remove the missing
    values. """


    #Now, we will iterate through the columns of df to remove any empty values
    for i in columns_of_df:
        #print(i) #This is to ensure I pick out the column names
        if df[i].isnull().sum() == 1:
            #We use the subset parameter to tell dropna to drop rows where data is missing.
            #Inplace is true to make sure changes are retained
            df.dropna(subset=[i],inplace=True) #FIND OUT WHAT DOES DROPNA DO

    #Now, let's confirm that all the missing values are gone

    #print(df.isnull().sum())

    #After running the code, we can see that every column has value 0. So, there is no missing value from each column.

    """Now, we will go onto taking measures about the data."""

    #First of all I want to pick the appropriate index for the data.
    #print(df.columns) #To see all possible options
    """After looking at the columns, it seems appropriate to pick 'Vehicle Speed' as the index as most of the relationship
    we are interested in is with respect to speed"""
    #df.set_index("VehicleSpeed", inplace=True) - I THINK THIS CREATED ISSUES LATER, COULDNT FIND COLUMN WHEN IT IS INDEX FIGURE OUT WHY
    #print(df)

    """Now, we want to count the number of unique values in each column of the data set. I would not expect every column 
    (except time, since it is linear) to be fully consist of unique values. For example, speed has to start and end at
    0. """
    for i in df.columns:
        unique_values = df[i].index.nunique() #'''WHAT DOES .INDEX DO? AND WHAT DOES .NUNIQUE DO?'''
        #print("The number of unique values in %d column is %d", i, unique_values) #WORK THIS OUT PROPERLY

    #print(df.shape)
    #Surprisingly, every column in the dataframe seem to have exactly 75500 unique values. Total number of columns is 93. WHY IS TIME UNIQUE TOO?

    """Now we want to see the non-null value counts"""
    #print(df.info())
    #Output tells us that the format of each column in float64 and the non-null count is 75500, which matches the
    #number of rows we have.

    """Now, we want to get a sense of the distribution of continuous variables. I will use the describe function and use
    histograms visualise the variable distribution. Before doing any analysis with a continuous variable, it is important
    to have a good understanding of how it is distributed - its central tendency, its spread, and its skewness. This will
    help me identify outliers and unexpected values."""

    #Now, let's get descriptive statistics on the Bengal data
    #print(df.describe()) # Note this does the same thing that we did way earlier on, but instead of reiterating through the
    #rows we can do this instead

    """Now, let's take a closer look at the describution of values for the columns. We will use the arange method to pass
    a list of floats from 0 to 1.0 to the quantile method of the dataframe."""
    #print(df.quantile(np.arange(0.0,1.1,0.1))) #'''FIGURE OUT HOW THIS CODE WORKS'''
    #CAN I VISUALISE THIS AS A HISTOGRAM?? - DO THAT. THAT IS MORE USEFUL. PLOT ALL OF THIS OUT USING MATLAB!!!! - DO THIS

    """Now, we will identify missing values and outliers in the subsets of data. Essentially, I want to focus on:
    (i) Finding missing values
    (ii) Identifying outliers with one variable
    (iii) Identifying outliers and unexpected values in bivariate relationships
    (iv) Using subsetting to examine logical inconsistencies in variable relationships
    (v) Using Linear regression to identify data points with significant influence
    (vi) Using K-nearest neighbors to find outliers
    (vii) Using Isolation Forest to find anomalies
    """

    # (i) Finding missing values

    # The objective is to get a good sense of the number of missing values for each variable, and why those variables are
    #missing. We would also want to know which rows in our data frame are missing values for several key variables.

    """I set the axis = 0 (the default) to check for the count of countries that are missing values for each of the 
    columns. After running the code, we will see that each column doesn't contain any missing values, which is great!!"""

    #FIGURE OUT WHAT 0 and ! DOES!!!

    for i in df.columns:
        #print(i)
        df[i].isnull().sum(axis=0)
        #print(df[i].isnull().sum(axis=0))

    #Now, I set the axis = 1 to check for missing values row wise
    #print(df.isnull().sum(axis=1))
    """It seems that running the code row wise, there isn't any missing data either."""

    """Now, we will move onto part (ii) Identifying outliers with one variable"""

    """Some notes on Outliers: The concepts of outliers is somewhat subjective. But it is closely tied to the properties
    of a particular distribution; to its central tendency, spread, and shape. We make assumptions about whether a value
    is expected or unexpected based on how likely we are to get that value given the variable's distribution. We are more
    inclined to view a value as an outlier if it is multiple standard deviations away from the mean, and it is from a 
    distribution  that is approximately normal; one that is symmetrical (has low skew) and has relatively skinny tails 
    (low kurtosis)."""

    # Skewness and Kurtosis descirbe how symmetrical the distribution is and how fat the tails of the distribution are
    #respectively

    #Now, to find the skew of our data. ADD DEFINITION
    df.skew()
    #print(df.skew())

    #Now, we find the kurtosis of the data
    df.kurtosis()
    #print(df.kurtosis()) #ADD DEFINITION

    '''FIND A WAY TO VISUALISE THIS'''

    #Now, we test the data for normality.
    """We will use the Shapiro-Wilk test from the scipy library. Print out the p-value from the test. The null hypothesis
     of a normal distribution can be rejected at the 95% level at any level below 0.05."""

    stat, p = scistat.shapiro(df) # READ UP ON THE STATISTICAL SIGNIFICANCE OF THIS
    #print(p)
    # Running this lead to the error: UserWarning: p-value may not be accurate for N>5000. So, googling led to the fact
    # that other tests of normality do not have this limitation such as the Kolmogorov-Smirnov test. So, I can consider
    # doing this. But the p-value I got is 0.0 - What does this mean? Does p-value=0 make senses in this case?

    """This code below shows the distribution of the data points of each column. From here, we can see how the distribution
    is. BUT LET'S POLT THIS AGAIN IN MATLAB, just for reference"""
    # Figure out why some of the plots are not plotted, there seems to be an issue with some of the columns like Vehicle
    # Speed

    #print(columns_of_df)
    #print(df["VehicleSpeed"]) #Okay so everything works after I commented out Vehicle Speed as my index in line 61. FIGURE OUT WHY
    for i in columns_of_df:
        sm.qqplot(df[[i]].sort_values([i]),line='s')
        plt.title(i)
        #plt.show()

    """Now, we want to identify the outlier on each column. One way to define an outlier for a continuous variable is by
     distance above the third quartile or below the first quartile. If that distance is more than 1.5 times the 
     interquartile range (the distance between first and third quartiles), that value is considered an outlier."""
    # Figure out why some of the plots are not plotted, there seems to be an issue with some of the columns like Vehicle
    # Speed
    for i in columns_of_df:
        thirdq, firstq = df[i].quantile(0.75), df[i].quantile(0.25)
        interquantilerange = 1.5*(thirdq-firstq)
        outlierhigh, outlierlow = interquantilerange + thirdq,  firstq - interquantilerange
        #print("The bounds of %i", i)
        #print(i)
        #print(outlierlow,outlierhigh,sep="<-->")

    '''FIND A WAY TO VISUALISE THIS'''

    #Identifying Outliers and Unexpected Values in Bivarate Relationships
    
    """A value might be unexpected, even if it is not an extreme value, when it does not deviate significantly from the
    distribution mean. Some values for a variable are unexpected when a second variable has certain values. Whenever, a
    variable of interest is significantly correlated with another variable, we should take that relationship into account
    when trying to identify outliers. """

    #Generate the correlation matrix
    df.corr(method="pearson") #Read up pearson!!!
    #print(df.corr(method="pearson"))

    for i in columns_of_df:
        pd.qcut(df[i],5,duplicates='drop')
        #print(pd.qcut(df[i],5,duplicates='drop'))

    """Using linear regression to identify data points with significance influence"""
    Y = df["VehicleSpeed"]
    X = df.loc[:, df.columns != 'VehicleSpeed']
    lm = sm.OLS(Y,X).fit()
    lm.summary()
    #print(lm.summary())

    #Using Isolation Forest to find anomalies

    #Create a standardised dataframe
    standardizer = StandardScaler()
    df_standardised = standardizer.fit_transform(df)
    #print(df_standardised)

    """
    #Run an Isolation Forest model to detect Outliers
    clf = IsolationForest(n_estimators=100, max_samples='auto')
    clf.fit(df_standardised)
    #print(clf.fit(df_standardised))
    df_standardised['anomaly'] = clf.predict(df_standardised)
    #print(df_standardised['anomaly'])
    df_standardised['scores'] = clf.decision_function(df_standardised)
    #print(df_standardised['scores'])

    #Now, work on how do I save the information i extracted into an excel sheet or something
    """


















main()
