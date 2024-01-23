## ggplot2 OVERVIEW ##

# the key package for creating graphs in tidyverse

# NOTE: ggplot uses "+" rather than |> (unlike rest of tidyverse)

# Three things to specify:
# 1. Data
# 2. Type of graph
# 3. Aesthetics/mapping 

#get some data and save it. 
library(tidyverse)
library(ggplot2)

oecd_gdp <-
  read_csv("https://stats.oecd.org/sdmx-json/data/DP_LIVE/.QGDP.../OECD?contentType=csv&detail=code&separator=comma&csv-lang=en")

write_csv(oecd_gdp, "inputs/data/oecd_gdp.csv")

oecd_gdp

oecd_gdp_2021_q3 <- 
  oecd_gdp |>
  filter( # <-filter to Q3, for particular countries 
    TIME == "2021-Q3",
    SUBJECT == "TOT",
    LOCATION %in% c(
      "AUS",
      "CAN",
      "CHL",
      "DEU",
      "GBR",
      "IDN",
      "ESP",
      "NZL",
      "USA",
      "ZAF"
    ),
    MEASURE == "PC_CHGPY"
  ) |>
  mutate(
    european = if_else( #<- make subplots 
      LOCATION %in% c("DEU", "GBR", "ESP"),
      "European",
      "Not european"
    ),
    hemisphere = if_else(
      LOCATION %in% c("CAN", "DEU", "GBR", "ESP", "USA"),
      "Northern Hemisphere",
      "Southern Hemisphere"
    ),
  )

oecd_gdp_2021_q3 |>
  ggplot(mapping = aes(x = LOCATION, y = Value, fill = european)) + # <- specify mapping, fill whether country is european/not
  geom_bar(stat = "identity") + # <- want a bar chart 
  labs( # <- specify labels 
    title = "Quarterly change in GDP for ten OECD countries in 2021Q3",
    x = "Countries",
    y = "Change (%)",
    fill = "Is European?"
  ) +
  theme_classic() + # <- change bckgrnd
  scale_fill_brewer(palette = "Set1") + # <- change color
  facet_wrap( # <- create subplots using facet; facet by hemisphere
    ~hemisphere,
    scales = "free_x"
  )