library(tidyverse)
library(dplyr)
library(ggplot2)

# load file as data frame
Utah <- read.csv("Data/Utah_Religions_by_County.csv")


# view file
glimpse(Utah)


library(scales)


# tidy the data
Utah <- Utah %>%
  mutate(Religious=percent(x = Religious,accuracy = 1)) %>%
  mutate(Non.Religious=percent(x = Non.Religious,accuracy = 1)) %>%
  mutate(Assemblies.of.God=percent(x = Assemblies.of.God,accuracy = 1)) %>%
  mutate(Episcopal.Church=percent(x = Episcopal.Church,accuracy = 1)) %>%
  mutate(Pentecostal.Church.of.God=percent(x = Pentecostal.Church.of.God,accuracy = 1)) %>%
  mutate(Greek.Orthodox=percent(x = Greek.Orthodox,accuracy = 1)) %>%
  mutate(LDS=percent(x =LDS,accuracy = 1)) %>%
  mutate(Southern.Baptist.Convention=percent(x = Southern.Baptist.Convention,accuracy = 1)) %>%
  mutate(United.Methodist.Church=percent(x = United.Methodist.Church,accuracy = 1)) %>%
  mutate(Buddhism.Mahayana=percent(x = Buddhism.Mahayana,accuracy = 1)) %>%
  mutate(Catholic=percent(x = Catholic,accuracy = 1)) %>%
  mutate(Evangelical=percent(x = Evangelical,accuracy = 1)) %>%
  mutate(Muslim=percent(x = Muslim,accuracy = 1)) %>%
  mutate(Non.Denominational=percent(x = Non.Denominational,accuracy = 1)) %>%
  mutate(Orthodox=percent(x = Orthodox,accuracy = 1))



#pivot longer to make graphing easier
Utah <-
  Utah %>% pivot_longer(cols=ends_with(c("God","Church","Orthodox","DS","tion","ana","al","ic","im")),
                        names_to = "Religion", values_to = "Percent_of_population")



# Exploring the data with different figures

# p1, showing religion % by country
p1 <- Utah %>% 
  ggplot(mapping = aes(x = County,y = Percent_of_population)) +
  geom_point() +
  facet_wrap(~Religion) +
  theme_dark() +
  theme(axis.text.x = element_text(angle = 90,
                                   vjust = 0.5,
                                   hjust =)) +
  theme(axis.text.y = element_text(size = 4))

# view p1
p1

# p2, showing county by religion % (opposite of p1)
p2 <- Utah %>% 
  ggplot(mapping = aes(x = Religion,y = Percent_of_population)) +
  geom_point() +
  facet_wrap(~County)+
  theme_dark() +
  theme(axis.text.x = element_text(angle = 90,
                                   vjust = 0.5,
                                   hjust =)) +
  theme(axis.text.y = element_text(size = 4))

# View p2
p2

# religious/non-religious vs population
p3 <- Utah %>% 
  ggplot(mapping = aes(x = Pop_2010,y = Religious)) +
  geom_point() +
  theme_dark() +
  theme(axis.text.x = element_text(angle = 90,
                                   vjust = 0.5,
                                   hjust =)) +
  theme(axis.text.y = element_text(size = 4))

# view p3
p3



# addressing the questions:
#Q: Does population of a county correlate with the proportion of any specific religious group in that county?

# Yes, according to p2 and p3, we see that as a counties population increases, they tend to be more religios

#Q: “Does proportion of any specific religion in a given county correlate with the proportion of non-religious people?”

# Yes, the proportion of Catholics in a given country correlates to the proporion of non-religious people.









