# Heathrow Airport Meteorological Data Analysis Project

## Overview

This repository contains the MATLAB code and functions developed for the Data Analysis course project. The project involves analyzing meteorological data from Heathrow Airport, focusing on various statistical analyses and hypothesis tests.

## Project Structure

The project is divided into five main exercises, each addressing different aspects of data analysis. The following sections describe each exercise and the corresponding MATLAB functions and scripts.

## Scripts and Functions
- `findUnderlyingDistribution.m`: This script calculates the Pearson's correlation coefficient and the mutual information between every pair of indicators.
- `compareMeanTemperature.m`: This script calculates the Pearson's correlation coefficient and the mutual information between every pair of indicators.
- `findPairsWithSignificantCorrelation.m`: This script finds the pairs of indicators that have a significant correlation.
- `findSignificantMeanDifference.m`: This script calculates the Pearson's correlation coefficient and the mutual information between every pair of indicators.
- `findSignificantMIPairs.m`: This script calculates the Pearson's correlation coefficient and the mutual information between every pair of indicators.
- `linearRegressionAnalysis.m`: This script performs full linear regression analysis for every pair of indicators and finds the best linear regression model for every pair of indicators.
- `nonLinearRegressionAnalysis.m`: This script performs a non-linear regression analysis for every pair of indicators and finds the best non-linear regression model for every pair of indicators. It searches up to 3rd degree polynomial models and the ln-transform model.
- `findPairsWithBestR2.m`: This script finds the pairs of indicators that have the best R^2 value.
- `regressionMethodsComparisons.m`: This script compares the linear and non-linear regression models for every pair of indicators.
- `findLASSOVariablesForFG.m`: This script finds the variables selected by the LASSO method for the full linear regression model for the FG indicator.

## Usage

1. Ensure all MATLAB scripts and functions are in the same directory.
2. Run each script in MATLAB to perform the corresponding analysis OR run the `main.m` script to run all analyses.
3. The results and plots will be generated and saved as specified in the scripts.

## Data

The meteorological data used in this project is sourced from `Heathrow.xlsx`, available on the course website. The data includes annual meteorological indicators for Heathrow Airport from 1949-1958 and 1973-2017.
