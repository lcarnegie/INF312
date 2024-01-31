#### Preamble ####
# Purpose: Simulates, tests, and plots flight data as per INF312 Quiz 4
# Author: Luca Carnegie
# Date: January 30 2024

#import relevant libraries
library(tidyverse)
library(ggplot2)

# (Simulate) Please further consider the scenario described 
# and simulate the situation. Please include three tests based 
# on the simulated data. Submit a link to a GitHub Gist that 
# contains your answer.

## Data Expectations##

#variables: hours after start, flights per hr 
#both values contain numbers within their specified ranges below

set.seed(46)

num_hrs <- 8

flights <- tibble(
  "Hours After Start" = 1:num_hrs, 
  "Number of Flights" = sample(0:51, num_hrs, replace = TRUE)
)

# TESTS

flights$`Hours After Start` |> max() == 8

flights$`Number of Flights` |> min() == 0

flights$`Number of Flights` |> max () == 51 

# PLOTTING 

flights |>
  ggplot(aes(x=`Hours After Start`, y=`Number of Flights`)) + 
  geom_line() + 
  labs(title="Hourly Change in Flight Traffic", x="Hours after Start", y="# of planes") + 
  theme_minimal() +
  #centre title
  theme( 
    plot.title.position = "plot",
    plot.title = element_text(hjust = 0.55)
  )
 


