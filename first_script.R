list.files(recursive = TRUE,pattern = "grade",ignore.case = TRUE,full.names = TRUE)

grades <- read.csv(./Data/FAke_grade_data.csv)
class(grades)

grades[3,c(1,3,5)]

#list of students

grades$Assignment_1 > 15

grades$Student[grades$Assignment_1 > 15]

library(tudyverse)
