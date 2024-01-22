#!! IMPORTANT: R scripts are like commands - ergo, you
# NEED to highlight and run commands individually. 

#Install the packages we need 
install.packages("tidyverse")
install.packages("AustralianPoliticians")

# Load the packages that we need to use this time
library(tidyverse)
library(AustralianPoliticians)

# Make a table of the counts of genders of the prime ministers
get_auspol("all") |> # Imports data from GitHub
  as_tibble() |> #tibble = dataframe
  filter(wasPrimeMinister == 1) |> #filter 
  count(gender) #display a count 

get_auspol("all") |>
  head() #show the first few lines of a dataset 

## ASSIGNING VARIABLES ##
aussie_politicians <- #assign to a variable 
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









  








  





    


