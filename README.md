# Heathrow Airport Meteorological Data Analysis Project

## Overview

This repository contains the MATLAB code and functions developed for the Data Analysis course project. The project involves analyzing meteorological data from Heathrow Airport, focusing on various statistical analyses and hypothesis tests.

## Project Structure

The project is divided into five main exercises, each addressing different aspects of data analysis. The following sections describe each exercise and the corresponding MATLAB functions and scripts.

## Exercises and Functions

### Exercise 1

**Objective:** Create a function to analyze sample observations and perform statistical tests.

**Functions:**
- `Group69Exe1Fun1.m`: Analyzes a vector of sample observations to determine if they follow a specific distribution. It performs the following tasks:
  - Counts distinct values in the vector.
  - If there are more than 10 distinct values, creates a histogram and performs Chi-squared tests for normal and uniform distributions. The p-values are displayed on the plot.
  - If there are 10 or fewer distinct values, creates a bar chart and performs Chi-squared tests for binomial and discrete uniform distributions. The p-values are displayed on the plot.

**Script:**
- `Group69Exe1Prog1.m`: Calls the above function for each meteorological indicator and collects the p-values in a table. The table indicates whether the indicator is continuous or discrete and the type of distribution it follows.

### Exercise 2

**Objective:** Create a function to compute confidence intervals for the mean.

**Functions:**
- `Group69Exe2Fun1.m`: Computes the 95% parametric and bootstrap confidence intervals for the mean of a vector of sample observations.

**Script:**
- `Group69Exe2Prog1.m`: Calls the above function for each of the first nine indicators using data from 1973 onwards. It checks if the sample mean from 1949-1958 falls within the computed confidence intervals and comments on the results.

### Exercise 3

**Objective:** Create a function to detect changes in mean values over time.

**Functions:**
- `Group69Exe3Fun1.m`: Analyzes two vectors representing years and corresponding observations to detect discontinuities and compare mean values across periods.
  - Detects the first discontinuity in the year vector.
  - Splits the observations into two periods based on the discontinuity.
  - Performs parametric (t-test) and resampling-based tests to compare the mean values between the two periods.

**Script:**
- `Group69Exe3Prog1.m`: Calls the above function for the first nine indicators and identifies indicators with significant changes in mean values between the two periods.

### Exercise 4

**Objective:** Create a function to analyze paired observations of two variables.

**Functions:**
- `Group69Exe4Fun1.m`: Analyzes two vectors of paired observations to:
  - Remove pairs with missing values.
  - Compute 95% confidence intervals for the correlation coefficient using Fisher's transformation and bootstrap methods.
  - Perform parametric and non-parametric tests for zero correlation.

**Script:**
- `Group69Exe4Prog1.m`: Calls the above function for all pairs of the first nine indicators and identifies pairs with significant linear correlations.

### Exercise 5

**Objective:** Analyze mutual information between variables.

**Functions:**
- `Group69Exe5Fun1.m`: Analyzes two vectors to compute mutual information and perform a non-parametric permutation test. Outputs the mutual information value, p-value, and the length of vectors without missing values.

**Script:**
- `Group69Exe5Prog1.m`: Calls the above function for selected pairs of indicators, computes the Pearson correlation coefficient and its significance, and compares it with mutual information results.

### Exercise 6

**Objective:** Perform randomization tests for the adjusted coefficient of determination.

**Functions:**
- `Group69Exe6Fun1.m`: Analyzes two vectors to compute the adjusted R-squared and performs a randomization test to evaluate its statistical significance. Outputs the adjusted R-squared value and p-value.

**Script:**
- `Group69Exe6Prog1.m`: Calls the above function for different pairs of indicators to evaluate the significance of their linear regression models.

### Exercise 7

**Objective:** Develop a function for non-linear regression analysis.

**Functions:**
- `Group69Exe7Fun1.m`: Fits a non-linear regression model to two vectors, computes the adjusted R-squared, and performs residual analysis. Outputs the model parameters and goodness-of-fit measures.

**Script:**
- `Group69Exe7Prog1.m`: Applies the above function to selected indicators to model non-linear relationships and assess their fit.

### Exercise 8

**Objective:** Compare linear and non-linear regression models.

**Functions:**
- `Group69Exe8Fun1.m`: Compares linear and non-linear models fitted to two vectors, using goodness-of-fit statistics and hypothesis tests.

**Script:**
- `Group69Exe8Prog1.m`: Uses the above function to compare models for different pairs of indicators and determines the better-fitting model.

### Exercise 9

**Objective:** Implement cross-validation for model evaluation.

**Functions:**
- `Group69Exe9Fun1.m`: Performs k-fold cross-validation for a given model and computes performance metrics such as RMSE and MAE.

**Script:**
- `Group69Exe9Prog1.m`: Applies cross-validation to evaluate the predictive performance of models for selected indicators.

### Exercise 10

**Objective:** Conduct time series analysis and forecasting.

**Functions:**
- `Group69Exe10Fun1.m`: Analyzes a time series for trends, seasonality, and autocorrelation. Fits ARIMA models for forecasting and evaluates their accuracy.

**Script:**
- `Group69Exe10Prog1.m`: Uses the above function to analyze and forecast future values of meteorological indicators based on historical data.

## Usage

1. Ensure all MATLAB scripts and functions are in the same directory.
2. Run each script in MATLAB to perform the corresponding analysis.
3. The results and plots will be generated and saved as specified in the scripts.

## Data

The meteorological data used in this project is sourced from `Heathrow.xlsx`, available on the course website. The data includes annual meteorological indicators for Heathrow Airport from 1949-1958 and 1973-2017.
