
#Install the packages we need 
install.packages("tidyverse")
install.packages("AustralianPoliticians")

# Load the packages that we need to use this time
library(tidyverse)
library(AustralianPoliticians)

# Make a table of the counts of genders of the prime ministers
get_auspol("all") |> # Imports data from GitHub
  as_tibble() |>
  filter(wasPrimeMinister == 1) |>
  count(gender) 
    


