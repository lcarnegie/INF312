##Setup
library(tidyverse)



library(lintr)
#Linted code using Lintr
set.seed(853)

tibble(
  age_days = runif(n = 10, min = 0, max = 36500),
  age_years = age_days %/% 365
)


# Parquet:
library(arrow)
library(fs)
num_draws <- 1000000

# Homage: https://www.rand.org/pubs/monograph_reports/MR1418.html
a_million_random_digits <-
  tibble(
    numbers = runif(n = num_draws),
    letters = sample(x = letters, size = num_draws, replace = TRUE),
    states = sample(x = state.name, size = num_draws, replace = TRUE),
  )

write_csv(x = a_million_random_digits,
          file = "a_million_random_digits.csv")

write_parquet(x = a_million_random_digits,
              sink = "a_million_random_digits.parquet")

# Take a look at the parquet vs csv file: such a big difference in file size! 

file_size("a_million_random_digits.csv")

file_size("a_million_random_digits.parquet")