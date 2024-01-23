### BASE R ###

# the tidyverse is a newer way of using R
# to do data science. BUT there is a lot 
# of functionality built into baseline R 
# with no packages. 

## classes ##
# like datatypes, essentially 

a_number <- 8
class(a_number)

a_letter <- "a"
class(a_letter)

#change class of an object 

a_number <- as.character(a_number) #to character
a_number 
class(a_number)

a_number <- as.factor(a_number) #to factor 
a_number
class(a_number)

#note: A “factor” is used for categorical data that can only 
#take certain values

age_groups <- factor(
  c("18-29", "30-44", "45-60", "60+")
)
age_groups
class(age_groups)

levels(age_groups) # <- display the categories  

# you can also add dates (tricky)
# can convert from a character to a date 

looks_like_a_date_but_is_not <- "2022-01-01"
looks_like_a_date_but_is_not 
class(looks_like_a_date_but_is_not) #<- "character"

is_a_date <- as.Date(looks_like_a_date_but_is_not)
is_a_date
class(is_a_date) #<- "Date"

is_a_date + 3 #<- "2022-01-04", add 3 days 

#Dataframes 
install.packages("AER")
library(AER)

data("ResumeNames", package = "AER")

ResumeNames |>
  head()

#change the class of several columns 
# they started as factors 

ResumeNames <- ResumeNames |>
  mutate(across(c(name, gender, ethnicity), as.character)) |>
  head()

class(ResumeNames$name)


## SIMULATING DATA ##

#get observations from the normal dist. 
set.seed(853) # <- you can draw the same random numbers again
              #    this is done by setting a "seed" 


number_of_observations <- 5

simulated_data <-
  data.frame(
    person = c(1:number_of_observations),
    std_normal_observations = rnorm(
      n = number_of_observations,
      mean = 0,
      sd = 1
    )
  )

simulated_data

simulated_data <- # add draws from uniform, Poisson, binomial dists. 
  simulated_data |>
  cbind() |> #uses cbind to add the new columns 
  data.frame(
    uniform_observations =
      runif(n = number_of_observations, min = 0, max = 10),
    poisson_observations =
      rpois(n = number_of_observations, lambda = 100),
    binomial_observations =
      rbinom(n = number_of_observations, size = 2, prob = 0.5)
  )

simulated_data

#add a favourite colour

simulated_data <-
  data.frame(
    favorite_color = sample(
      x = c("blue", "white"),
      size = number_of_observations,
      replace = TRUE
    )
  ) |>
  cbind(simulated_data)

simulated_data


## FUNCTION() ##
# R is a functional language. Usually package and stuff have been
# written, but for specific cases we need to write our own functions

print_names <- function(some_names) {
  print(some_names)
}

print_names(c("rohan", "monica"))

#can also specify defaults 

print_names <- function(some_names = c("edward", "hugo")) {
  print(some_names)
}

print_names()

## FOR() ##
# a loop. 

# Create a vector of names
names <- c("Edward", "Hugo")

# Initialize empty vector for results 
results <- c()

# Loop through the names  
for(i in names) {
  # Print each name 
  results[i] <- print(i) 
}

# Print the results 
print(results)


## APPLY() ##
# Because R is a programming language that is 
# focused on statistics, we are often interested 
# in arrays or matrices. We use apply() to apply 
# a function to rows (“MARGIN = 1”) or columns (“MARGIN = 2”)

simulated_data
apply(X = simulated_data, MARGIN = 2, FUN = unique)
