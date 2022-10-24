library(tidyverse)


# learning about tidy data
# Rule1: EVERY column is a single variable

read_csv("./Data/wide_income_rent.csv")

df <- read_csv("./Data/wide_income_rent.csv")

df %>% 
  ggplot(aes(x=)) #????

# Tidy Rules
# Rule1: EVERY column is a single variable
# Rule2: Every row is a single observation of those variable
# Rule3: Must be rectangular (missing cells have NA)


# Wide format means that some variable(s) are spread across multiple columns
library(readxl)

df2 <- read_csv("./Data/wide_income_rent.xlsx")
