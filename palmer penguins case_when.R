library(carData)
library(tidyverse)


df <- full_join(MplsStops,MplsDemo)

glimpse(df)
levels(df$problem)
levels(df$citationIssued)
levels(df$personSearch)




df$citationIssued %>% 
  table()

df$citationIssued %>% 
  summary()

df %>% glimpse()

df <- df %>% 
  mutate(citationIssued = case_when(citationIssued == "YES" ~ TRUE,
                                    TRUE ~ FALSE),
         vehicleSearch = case_when(vehicleSearch == "YES" ~ TRUE,
                                   TRUE ~ FALSE),
         suspiciousVehicleSearch = case_when(problem == "suspicious" & vehicleSearch == TRUE ~ TRUE,
                                             TRUE ~ FALSE))


df$suspiciousVehicleSearch %>% summary
df$vehicleSearch %>% summary

df %>% 
  ggplot(aes(x = long,y = lat, color = suspiciousVehicleSearch)) +
  geom_point()


library(palmerpenguins)

df <- penguins



df %>% 
  mutate(Chonker = case_when(
   body_mass_g >= 4000 ~ TRUE,
            TRUE ~ FALSE)) %>% 
  ggplot(aes(x = flipper_length_mm, y = body_mass_g, color = Chonker)) +
  geom_point()

penguins %>% 
  filter(!is.na(sex)) %>% 
  mutate(size = case_when(body_mass_g >= 5000 ~ "FatBoy",
                          body_mass_g >= 4000 & body_mass_g < 5000 ~ "Kindafat",
                          body_mass_g < 4000 ~ "SmolBoy")) %>% 
  ggplot(aes(x=body_mass_g,fill = size)) +
  geom_histogram(alpha=.5) +
  facet_wrap(~species*sex)




penguins

#