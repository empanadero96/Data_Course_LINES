library(tidyverse)
library(readxl)
library(janitor)

# path to file
path <- "./Data/messy_bp.xlsx"


# read data
df <- read_xlsx(path,skip = 3) %>% 
  clean_names()

# get list of visits
extranames <- read_xlsx(path,skip = 2,n_max = 1) %>%
  select(starts_with("Visit ")) %>% 
  names() %>% make_clean_names()

# separate out all the data
bp <- df %>% 
  select(starts_with("bp_"))

# heart rate
hr <- df %>% 
  select(starts_with("hr_"))

# patients
patients <- 
  df %>% 
  select(-starts_with("bp_")) %>% 
  select(-starts_with("hr_"))

paste0(patients$year_birth,"-",
       patients$month_of_birth,"-",
       patients$day_birth) %>% 
  as.Date()


# make and clean patients
patients <- 
patients %>% 
  mutate(birthdate = as.Date(paste0(year_birth,"-",
                                    month_of_birth,"-",
                                    day_birth))) %>% 
  select(-contains("_birth")) %>% 
  mutate(pat_id = 1:nrow(.)) %>% 
  mutate(hispanic = case_when(hispanic == "Hispanic" ~ TRUE,
                              TRUE ~ FALSE)) %>% 
  mutate(race = race %>%  str_to_lower() %>% 
           str_replace("caucasian","white"),
         sex = sex %>% str_to_lower())

# new blood pressure column names
names(bp) <- extranames
names(bp)

# new heart rate column names 
names(hr) <- extranames
names(hr)

bp <- 
patients %>% 
  bind_cols(bp) %>% 
  pivot_longer(starts_with("visit_"),names_to="visit",values_to = "bp") %>% 
  separate(bp, into =c("systolic", "diastolic"),convert = TRUE)

hr <- 
  patients %>% 
  bind_cols(hr) %>% 
  pivot_longer(starts_with("visit_"),names_to="visit",values_to = "hr")

df <- full_join(bp,hr) %>% 
  mutate(visit = visit %>% str_remove("visit_") %>% 
           as.numeric())

saveRDS(df,"./Data/clean_bp.RDS")

df %>% 
  ggplot(aes(x=visit,y=systolic,color=hispanic)) +
  geom_point() +
  geom_smooth()

  
  
  
  
  
  
  
  
  
  




















