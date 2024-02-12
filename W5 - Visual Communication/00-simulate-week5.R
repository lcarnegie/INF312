#### Preamble ####
# Purpose: Simulates, tests, and plots flight data as per INF312 Quiz 5
# Author: Luca Carnegie
# Date: February 7 2024

#import relevant libraries
library(tidyverse)
library(ggplot2)

# (Simulate) Please further consider the scenario described 
# and simulate the situation. Please include three tests based 
# on the simulated data. Submit a link to a GitHub Gist that 
# contains your answer.

## Data Expectations##

#variables: friend #, Ash, Jacki, Matt, Mike, Rol
#all values contain numbers within their specified ranges below

# Load necessary library
library(dplyr)

# Set seed for reproducibility
set.seed(123)

# Number of friends
n_friends <- 20

# True heights
true_heights <- sample(rnorm(n_friends, mean = 170, sd = 10), n_friends, replace = TRUE)

# Measurement errors
measurement_errors <- sample(rnorm(n_friends, mean = 0, sd = 3), n_friends, replace = TRUE)

# Measurements by each friend
ash_measurements <- true_heights + measurement_errors
jacki_measurements <- true_heights + measurement_errors
matt_measurements <- true_heights + measurement_errors
mike_measurements <- true_heights + measurement_errors
rol_measurements <- true_heights + measurement_errors

# Combine into a data frame
height_data <- tibble(
  Friend = 1:n_friends,
  Ash = ash_measurements,
  Jacki = jacki_measurements,
  Matt = matt_measurements,
  Mike = mike_measurements,
  Rol = rol_measurements
)

# Some simple tests: 



measurements <- c(height_data$Ash, 
                      height_data$Jacki, 
                      height_data$Matt, 
                      height_data$Mike, 
                      height_data$Rol
                      )

#Check that all observations at at or above 150 
all(measurements >= 150)

#Check that our range falls within a certain interval 
all(measurements >= 150 & measurements <= 190)

# Check if any values fall below 145
all(measurements < 145)


# Create the bar plot
ggplot(data, aes(x = MeasuredBy, y = Height, fill = Friend)) +
  geom_bar(stat = "identity") +
  labs(x = "Measured By", y = "Height") +
  theme_minimal() +
  scale_fill_manual(values = rainbow(11)) 






 


