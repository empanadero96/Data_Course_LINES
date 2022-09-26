library(dplyr)
library(tidyverse)
library(patchwork)
library(ggplot2)

list.files(path = "data",
           full.names = TRUE,
           recursive = TRUE,
           pattern = "cleaned_covid_data")

read.csv("data/cleaned_covid_data.csv")

# Task1
data <- read.csv(file = "data/cleaned_covid_data.csv")

# Task2
A_states <- subset(data %>% 
  filter(grepl("A", Province_State)))

# Task3
p1 <- A_states %>% 
  ggplot(mapping=aes(x = Last_Update,y = Deaths)) +
  geom_point(size=0.0000005, shape=23) +
  geom_smooth(method = "loess",se = FALSE, formula = y ~ x) +
  facet_wrap(~Province_State) +
  theme_bw()

p1


# Task4
state_max_fatality_rate <- subset(data,select = -c(Deaths,Active,Recovered,Confirmed)) %>% 
  arrange(desc(Case_Fatality_Ratio)) %>% 
  na.omit(state_max_fatality_rate)

  
require(data.table)
dt <- data.table(state_max_fatality_rate)
dt[ , max(Case_Fatality_Ratio), by = Province_State]

state_max_fatality_rate <- dt[ , max(Case_Fatality_Ratio), by = Province_State]

rm(dt)

# Task5

p2 <- ggplot(data = state_max_fatality_rate,
             aes(x= reorder(Province_State, -V1),Province_State,y=V1))+
  geom_bar(stat = "identity") +
  theme_bw()+
  xlab("State")+
  ylab("Max Fatality Ratio")+
  theme(axis.text.x = element_text(angle = 90,size = 6))

p2

