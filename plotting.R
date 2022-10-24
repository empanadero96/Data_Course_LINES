#load packages
library(tidyverse)

#load data
data("iris")

#rename the iris object
df <- iris
glimpse(iris)

#plot
ggplot(data = df,
       mapping = aes(x = Petal.Length,
                     y = Petal.Width,
                     color = Species,
                     shape = Species,
                     size =  Sepal.Length)) + 
  geom_point() + 
  geom_smooth(method = "lm")

# box plot
ggplot(df,
       mapping=aes(x=Species,
           y=Sepal.Length,
           fill=Species)) +
  
  geom_violin() +
  geom_jitter(width = .2,height = 0,alpha=.5) +
  theme_dark()

?geom_density_2d_filled

# aesthetics NEED to be the name of the column in your data file

ggplot(df,
       aes(x=Sepal.Length,y=Sepal.Width,color=Species)) +
  geom_point() +
  geom_smooth(method = "lm",se=FALSE)

df <- read_delim("./Data/DatasaurusDozen.tsv")


  


