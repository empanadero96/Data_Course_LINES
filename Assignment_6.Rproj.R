library(tidyverse)
library(dplyr)

list.files(path = "Data",
           recursive = TRUE,
           full.names = TRUE,
           pattern = "BioLog")

dat <- read_csv("Data/BioLog_Plate_Data.csv")

#Task1 & 2
dat %>%
  pivot_longer(cols = starts_with("Hr"), names_to = "Hour", values_to = "Absorbance") %>%
  mutate(Source = case_when(
    startsWith(`Sample ID`, "S") ~ "soil",
    startsWith(`Sample ID`, "C") ~ "water",
    startsWith(`Sample ID`, "W") ~ "water"
  ))

#Task3

p1 <- dat %>%
  pivot_longer(cols = starts_with("Hr"), names_to = "Hour", values_to = "Absorbance") %>%
  mutate(Source = case_when(
    startsWith(`Sample ID`, "S") ~ "soil",
    startsWith(`Sample ID`, "C") ~ "water",
    startsWith(`Sample ID`, "W") ~ "water"
  )) %>%  ggplot(mapping = aes(x = Hour, y = Absorbance))+geom_line()+geom_smooth(method = lm, aes(color=Source))+
  facet_wrap(~Substrate)

p1



                  


  