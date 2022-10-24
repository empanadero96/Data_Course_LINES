library(tidyverse)
library(patchwork)

data <- iris


# save a plot as an object
p1 <- ggplot(data, mapping = aes(x = Sepal.Length,y = Sepal.Width, color = Species)) +
  geom_point() + geom_smooth(method =lm,se = FALSE)

p3 <- ggplot(data,aes(x=Species,y=Sepal.Length)) +
  geom_boxplot()

# Create directory
dir.create("Figures")

#save plot as figure
ggsave("./Figures/myfirstplot.png",plot = p3,width = 6,height = 6,dpi = 300)

# Using patchwork to combine multiple plots
(p1 + p3)


# Edit after saving
p3 + theme_minimal() + 
  labs(y="Speal Lenth",
       title = "AMOG SUS",
       subtitle = "imposter",
       caption = "Data from iris")

p4 <- p3 + theme_minimal() + 
  labs(y="Speal Lenth",
       title = "AMONGUS",
       subtitle = "imposter",
       caption = "Data from iris")

ggsave("./Figures/mysecondplot.png",plot = p3,width = 6,height = 6,dpi = 300)

p4 + 
  theme(axis.text.x = element_text(face = "italic",
                                   size = 14,
                                   color = "blue"),
        plot.background = element_rect(fill = "pink"),
        axis.title = element_text(size = 18,face = "bold"))

p6 <- ggplot(iris,aes(x = Species,y = Sepal.Length,fill = Species)) +
  geom_boxplot()

# take new colors from google color picker
pal <- c("#329ea8", "#3268a8", "#a8326b")

# add them to p6
p6 + 
  scale_fill_manual(values = pal)

ggplot(iris,aes(x=Sepal.Length,
                y=Sepal.Width,
                color=Sepal.Width)) +
                geom_point() +
                  scale_color_viridis_c(option = "inferno")














