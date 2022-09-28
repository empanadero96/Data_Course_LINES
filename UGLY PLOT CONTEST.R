library(tidyverse)


data %>%
  filter(Sepal.Length < 7 & Sepal.Length>5.6) %>% 
  ggplot(aes(x=Sepal.Length,y=Sepal.Width,color=Species)) +
  geom_area() +
  facet_wrap(~Species)+
  geom_smooth(method = lm,se = TRUE,aes(color=Species)) +
  theme_linedraw() + 
  theme(strip.text = element_text(face = "bold.italic"),
        legend.position = "left") +
  labs(y="data from some f*****' nerds who like flowers",
       title = "AMOZING DATA",
       caption = "Please help, there is a man with a gun behind the counter") +
  theme_dark()

