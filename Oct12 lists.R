library(tidyverse)
library(janitor)

# what is a list

class(1:10)
class(c(1,2,3,"a"))

(c(1,2,3,"a")[2])

list("a",2,TRUE,c(1,2,3))

x <- list(sentences = sentences,
          letters = letters,
          numbers =1:10,
          iris = iris,
          whatever = TRUE)

df <- iris

x$numbers
x$sentences

map(x,1) %>% class

sentences %>% 
  map(1) %>% map(1)

str_split(sentences," ") %>% 
  map_chr(1) %>% 
  table() %>% 
  as.data.frame() %>% 
  arrange(desc(Freq))

# load in the file
files <- list.files("./Data/data-shell/names",
           recursive = TRUE,
           full.names = TRUE,
           pattern = "adjustment")

read_clean <- function(x){read_csv(x) %>% 
    clean_names()}

# make lists easier to look at
dfs <- map(files,read_clean)
df <- reduce(dfs,full_join)
df %>% head()


# learn the diff between single and double brackets
x %>% names
x %>% length
x[[1]][800]

x[[4]][1] %>% class
x[[4]][[1]] %>% class

x$iris[1]
x$iris[[1]]


# function to clean up commas and periods
clean_up_commas <- function(x){
  x %>% str_remove(",") %>% 
    str_remove("\\.")
}

# find the most common word in the sentences list
sentences %>% 
  str_split(" ") %>% 
  map(str_to_lower) %>% 
  map(clean_up_commas) %>% 
  unlist() %>%
  table() %>% 
  as.data.frame() %>% 
  arrange(desc(Freq)) %>% 
  head()


# modelling
mpg %>% 
  ggplot(aes(x=displ,y=cty,color=drv)) +
  geom_point() +
  geom_smooth(method="lm")

mod1 <- mpg %>% 
  glm(data=.,
      formula = cty ~ displ + drv)

summary(mod1)


newdata <- data.frame(drv=factor("f"),
                     displ =5)

predict(mod1,newdata)


