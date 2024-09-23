# Project - Getting and Cleaning Data using the UCI HAR Dataset

## Overview
This project involves analysing data collected from the accelerometers and gyroscopes of smartphones to recognize human activities. The goal is to create a tidy dataset that includes average measurements for various activities performed by subjects.

## Data Source
The dataset used for this analysis is the "UCI HAR Dataset," which contains data from smartphone sensors for various activities such as walking, walking upstairs, walking downstairs, sitting, standing, and laying.

## Project Structure
- `CodeBook.md`: A detailed description of the variables, data transformations, and summaries calculated during the project.
- `tidy_average_data.csv`: The final tidy dataset containing average measurements for each activity and subject.
- `run_analysis.R`: The main R script that performs data cleaning and analysis.

## Steps Taken
1. **Load Data**: Combined training and test datasets for feature measurements, activity labels, and subject IDs.
2. **Extract Mean and Standard Deviation**: Filtered the dataset to include only measurements related to the mean and standard deviation.
3. **Add Descriptive Activity Names**: Merged activity labels with the main dataset to provide descriptive names for activities.
4. **Label Variables**: Renamed variables for clarity and consistency.
5. **Create Tidy Dataset**: Calculated the average of each variable for each activity and subject and saved the result to a txt file.

## Running the Analysis
To run the analysis, execute the `run_analysis.R` script in R. This script will perform all data processing steps and generate the `tidy_average_data.txt` file.

## Dependencies
- R (version 4.0 or higher)
- R packages: `dplyr`, `tidyverse`

## Author
Blessing Azubuike


