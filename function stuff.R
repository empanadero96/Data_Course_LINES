library(tidyverse)

# learning about functions

x <- 1:10
sum(x)

my_sum <- function(x){sum(x,na.rm = TRUE)}

y <- c(1:3,NA)

sum(y)
my_sum(y)

mpg


function_1 <- function(mpg){
  ggplot(mpg, aes(x = displ,y = cty)) +
    geom_point()
}

function_1(mpg)



#function

x <- mpg
var1 <- "year"
var2 <- "cty"

function_2 <- function(x,var1,var2){
  
  x <- as.data.frame(x)
  
  if(!is.data.frame(x)){stop("x is not a data frame, you idiot!")}
  if(!is.character(var1)){stop("var1 is not a character, you idiot!")}
  if(!is.character(var2)){stop("var2 is not a character, you idiot!")}
  

  ggplot(x, aes(x=x %>% pluck(var1),
                y=x %>% pluck(var2))) +
    geom_point() +
    labs(x=var1,
         y=var2) +
    theme_minimal()
}

is.character("cty")

#these wont work
function_2(,"hwy","cty")

function_2(mpg,5,"cty")

function_2(iris,"Sepal.Length","Sepal.Width")


# take a vector of numbers
# calculate the absolute difference between each number and the minimum value

abs(-5)

abs_min_diff <- function(x){
  if(!is.numeric(x)){stop("x must be a numeric vector")}
  abs(x-min(x))
}

abs_min_diff(-10:10)
#
































