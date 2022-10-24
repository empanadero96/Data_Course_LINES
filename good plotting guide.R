library(tidyverse)
 data <- iris

 # R challenge
 # using mutate() and filter() pick the rows of iris where at least 2 of any of the
 # following conditions are met:
 #   Sepal.Length is greater than 5.8
 #   Sepal.Width is greater than 3
 #   Petal.Length is greater than 3.7
 #   Petal.Width is greater than 1.2
 # So, the rows must meet TWO OR MORE of those conditions
 # your hint...
fat_flowers <- 
iris %>% 
   mutate(c1 = Sepal.Length > 5.8,
          c2 = Sepal.Width > 3,
          c3 = Petal.Width > 1.2,
          c4 = Petal.Length > 3.7,
          conditions = c1 + c2 + c3 + c4) %>% 
   filter(conditions >= 2) %>% 
  select(-starts_with("c"))
# select(-) means DOESN'T select those

#filter is for picking ROWS
#select is for picking COLUMNS
#mutate is for creating or changing column values

 iris %>% 
   filter(Sepal.Length > 5.8,
          Sepal.Width > 3,
          Petal.Length > 3.7,
          Petal.Width > 1.2)

iris %>% 
  ggplot(aes(x=Sepal.Width,y=Petal.Width,color=Species)) +
  geom_blank() +
  geom_point(data=fat_flowers)

library(palmerpenguins)

penguins %>% glimpse
penguins %>% GGally::ggpairs()

penguins %>% names()

penguins %>% 
  filter(!is.na(sex)) %>% 
  ggplot(aes(x=sex,y=body_mass_g,fill=sex)) +
  geom_boxplot() +
  facet_wrap(~island) +
  scale_fill_manual(values=c("Blue","Green")) +
  theme_bw()+
  theme(strip.background = element_rect(fill="White",size = 3),
        axis.text = element_text(size = 10))


  



 