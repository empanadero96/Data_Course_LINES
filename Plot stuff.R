library(GGally)
GGally::ggpairs(iris)

library(tidyverse)


iris %>% 
  ggplot()%>%  
  plot()

iris

ggplot(iris)

sum(1:10)

1:10 %>% sum()


iris %>%
  
  ggplot(aes(x=Sepal.Length,y=Sepal.Width,color=Species)) +
  geom_point()

iris %>%
  filter(Species != "setosa") %>% 
  filter(Sepal.Length < 7 & Sepal.Length>5) %>% 
  ggplot(aes(x=Sepal.Length,y=Sepal.Width,color=Species)) +
  geom_point() +
  facet_wrap(~Species) # separate subplots for each level of a categorical

# ~ means "as a function of"
data("iris")
iris %>% 
  ggplot(aes(x=Sepal.Length,y=Petal.Length)) + geom_point() +
  facet_wrap(~Species) +
  geom_smooth(method = lm,se = TRUE,aes(color=Species)) +
  theme_bw() + 
  theme(strip.text = element_text(face = "italic"),
          legend.position = "left")


iris %>% 
  ggplot(aes(x=Species,y=Petal.Length)) +
  geom_violin()

str(iris)
iris %>% (str)

# BAD: levels(iris$Species) <- c("virginica","virginica","setosa")


iris %>% 
  mutate(Sepal.Area = Sepal.Length * Sepal.Width,
         Species = factor(Species,levels = c("virginica","virginica","setosa")))


