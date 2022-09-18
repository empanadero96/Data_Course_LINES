list.files (path = "data",
            full.names = TRUE,
            recursive = TRUE,
            pattern = "2004")

read.csv(file = "data/2004-2016-Short-Races.csv")

# This is data obtained (and shortened) from the fastest 100m dash runners
# This is a very short table, comprised of the names of the runner, their reaction time, and their final time.
data <- read.csv(file = "data/2004-2016-Short-Races.csv")

library(tidyverse)
library(patchwork)

p1 <- ggplot(data, mapping = aes(x = FINAL.TIME,y = REACTION.TIME)) +
  geom_point()

# Here is a plot of the the fastest runners and their reaction times
p1

# Adding a line to show the average distribution
p2 = p1 + geom_smooth(method =lm,se = FALSE)

# p2, p1 with a line
p2
