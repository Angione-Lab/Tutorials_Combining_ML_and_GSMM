# Import libraries for feature scaling and selection, fitting and  evaluation of the survival model
import sksurv
import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler()
from sksurv.linear_model import CoxPHSurvivalAnalysis
from sksurv.metrics import concordance_index_censored

# Load flux data as the X variable
X = pd.read_csv('fluxes.csv')
# Load survival data as the Y variable
Y = pd.read_csv('survival_data.csv')

# Define the training and test sets and specify the proportion of data to be used as the test set
X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size = 0.2, random_state = 1)

# Perform feature scaling on the flux data
sc_X = StandardScaler()
X_train = sc_X.fit_transform(X_train)
X_test = sc_X.transform(X_test)

# Fit the training data to the Cox proportional hazards model
estimator = CoxPHSurvivalAnalysis()
estimator.fit(X_train, Y_train)

# Evaluate the fit of the survival model using Harrell`s concordance index
result = concordance_index_censored(Y_test['Event'], Y_test['Time'], prediction)
