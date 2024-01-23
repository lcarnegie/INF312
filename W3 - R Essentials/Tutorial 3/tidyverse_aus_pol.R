#!! IMPORTANT: R scripts are like commands - ergo, you
# NEED to highlight and run commands individually. 

### THE TIDYVERSE ###

#Install the packages we need 
install.packages("tidyverse")
install.packages("AustralianPoliticians")

# Load the packages that we need to use this time
library(tidyverse)
library(AustralianPoliticians)

## TIBBLES AND OBJECTS ## 

# Make a table of the counts of genders of the prime ministers
get_auspol("all") |> # Imports data from GitHub
  as_tibble() |> #tibble = dataframe
  filter(wasPrimeMinister == 1) |> #filter 
  count(gender) #display a count 

get_auspol("all") |>
  head() #show the first few lines of a dataset 

## ASSIGNING TO OBJECT ##
aussie_politicians <- #assign to a object
  get_auspol("all") 

head(aussie_politicians) #same as line 16

## SELECT ##
aussie_politicians |> #1. the tidyverse way (returns tibble)
  select(firstName)

aussie_politicians$firstName |> #2. base R way (returns a vector)
  head()

aussie_politicians |>
  select(-firstName) #everything but firstName

#select() all of the columns 
# that start with, say, “birth”.
aussie_politicians |>
  select(starts_with("birth"))

#see also: starts_with(), ends_with(), and contains()

#make dataset smaller
aussie_politicians <-
  aussie_politicians |>
  select(
    uniqueID,
    surname,
    firstName,
    gender,
    birthDate,
    birthYear,
    deathDate,
    member,
    senator,
    wasPrimeMinister
  )

aussie_politicians 
#output ain't saved unless applied to an object, like aussie politicians

## FILTERING ## 

aussie_politicians |>
  filter(wasPrimeMinister == 1)

#AND operator 
aussie_politicians |> # 1. filter w mult. conditions
  filter(wasPrimeMinister == 1 & firstName == "Alfred")

aussie_politicians |> # same as 1. 
  filter(wasPrimeMinister == 1, firstName == "Alfred")

#OR operator 
aussie_politicians |> #find only Myleses or Ruths 
  filter(firstName == "Myles" | firstName == "Ruth")

aussie_politicians |> #use piping to make it pretty 
  filter(firstName == "Ruth" | firstName == "Myles") |>
  select(firstName, surname)

#filter a particular row (slice )

aussie_politicians |>
  filter(row_number() == 853)

aussie_politicians |>
  slice(853)

#Remove something 
aussie_politicians |>
  slice(-1)

#keep the first three rows
aussie_politicians |>
  slice(1:3)

#duplicate first two rows
aussie_politicians |>
  slice(1:2, 1:n())

## ARRANGE ##

#arrange politicians by their birthday, ASCENDING down the col
aussie_politicians |>
  arrange(birthYear)

#arrange politicians by their birthday, DESCENDING down the col
aussie_politicians |>
  arrange(desc(birthYear))

#alternatively, use the minus sign 
aussie_politicians |>
  arrange(-birthYear)

#can arrange also based on more than one column
aussie_politicians |>
  arrange(firstName, birthYear)

#alternatively, just pipe those two (order is reversed!)
aussie_politicians |>
  arrange(birthYear) |>
  arrange(firstName)

#in both cases, BE CLEAR about PRECEDENCE
#it will make the tibble look different. 
aussie_politicians |>
  arrange(birthYear, firstName)

# !! within arrange(), across() is helpful since 
# it enables you to use the selection helpers. 

aussie_politicians |>
  arrange(across(c(firstName, birthYear)))

aussie_politicians |>
  arrange(across(starts_with("birth")))

## MUTATE ##

#Create new columns from other columns 

# make a new column that is 1 if a 
# person was both a member and a senator and 0 otherwise

aussie_politicians <- 
  aussie_politicians |>
  mutate(was_both = if_else(member == 1 & senator == 1, 1, 0))

#useful with math

aussie_politicians <-
  aussie_politicians |>
  mutate(age = 2022 - year(birthDate))

aussie_politicians |>
  select(uniqueID, age)

#some functions: 
# log(), natural log 

aussie_politicians |>
  select(uniqueID, age) |>
  mutate(log_age = log(age))

# lead(), push values UP by 1 row

aussie_politicians |>
  select(uniqueID, age) |>
  mutate(lead_age = lead(age))

# lag(), push vals DOWN by 1 row

aussie_politicians |>
  select(uniqueID, age) |>
  mutate(lag_age = lag(age))

# cumsum(), cumulative sum of col

aussie_politicians |>
  select(uniqueID, age) |>
  drop_na(age) |>
  mutate(cumulative_age = cumsum(age))

# can also use it with across() to use select() helpers

aussie_politicians |> # across
  mutate(across(c(firstName, surname), str_count)) |>
  select(uniqueID, firstName, surname)

library(lubridate)

aussie_politicians |> #case_when
  mutate(
    year_of_birth = year(birthDate),
    decade_of_birth = 
      case_when( #much more readable than if-eles
        year_of_birth <= 1929 ~ "pre-1930",
        year_of_birth <= 1939 ~ "1930s",
        year_of_birth <= 1949 ~ "1940s",
        year_of_birth <= 1959 ~ "1950s",
        year_of_birth <= 1969 ~ "1960s",
        year_of_birth <= 1979 ~ "1970s",
        year_of_birth <= 1989 ~ "1980s",
        year_of_birth <= 1999 ~ "1990s",
        TRUE ~ "Unknown or error"
      )
  ) |>
  select(uniqueID, year_of_birth, decade_of_birth)

## SUMMARIZE ## 

aussie_politicians |>
  summarise(
    youngest = min(age, na.rm = TRUE),
    oldest = max(age, na.rm = TRUE),
    average = mean(age, na.rm = TRUE)
  )

aussie_politicians |>
  mutate(days_lived = deathDate - birthDate) |>
  drop_na(days_lived) |>
  summarise(
    min_days = min(days_lived), 
    mean_days = mean(days_lived) |> round(), 
    max_days = max(days_lived),
    .by = gender # group by the basis of one group 
  )

# .by can ALSO be used with MULTIPLE GROUPS 

aussie_politicians |>
  mutate(days_lived = deathDate - birthDate) |>
  drop_na(days_lived) |>
  summarise(
    min_days = min(days_lived),
    mean_days = mean(days_lived) |> round(),
    max_days = max(days_lived),
    .by = c(gender, member) # <---- see here 
  )

# you can count by groups too

aussie_politicians |>
  count(gender)

#calculate a proportion

aussie_politicians |>
  count(gender) |>
  mutate(proportion = n / (sum(n)))

# Using count() is essentially the same as using .by 
# within summarise() with n(), and we get the same 
# result in that way.

aussie_politicians |>
  summarise(n = n(),
            .by = gender)

aussie_politicians |>
  add_count(gender) |> # similar to mutate()
  select(uniqueID, gender, n)