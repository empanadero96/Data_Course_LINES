# More about models

library(tidyverse)
library(modelr)
library(easystats)
library(palmerpenguins)
library(broom)

df <- penguins

names(penguins)

# response is body_mass_g (traditionally on the Y axis)
# A model needs a response and predictors

# predictors: island, sex, species, ...

df %>% 
  filter(!is.na(sex)) %>% 
  ggplot(mapping = aes(y = body_mass_g,
                       x = species,
                       fill = sex)) +
  geom_boxplot() +
  facet_wrap(~island) +
  theme(axis.text.x = element_text(angle=90,hjust=1))


# formula:response ~ predictors


mod1 <- glm(data = penguins %>% 
      filter(!is.na(sex)),
    formula = body_mass_g ~ sex + island + species)

summary(mod1)

# use the tidy function to make it into a data fram
tidy(mod1) %>% 
  filter(p.value < 0.05)

mod2 <- glm(data = penguins %>% 
              filter(!is.na(sex)),
            formula = body_mass_g ~ sex + island)

tidy(mod2) %>% 
  filter(p.value < 0.05)

# easystats
report(mod2)
model_performance(mod2)
compare_performance(mod1,mod2)

mod3 <- glm(data = penguins %>% 
              filter(!is.na(sex)),
            formula = body_mass_g ~ sex * species)

compare_performance(mod2,mod3,mod1)

mod4 <- glm(data = penguins %>% 
              filter(!is.na(sex)),
            formula = body_mass_g ~ .^2)

mod4 %>% summary()

step <- MASS::stepAIC(mod4)

step$formula










