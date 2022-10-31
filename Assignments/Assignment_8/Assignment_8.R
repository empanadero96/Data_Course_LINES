# load up the necessary packages
library(modelr)
library(easystats)
library(broom)
library(tidyverse)
library(fitdistrplus)

# task 1: load the “/Data/mushroom_growth.csv” data set
read_csv(file = "mushroom_growth.csv")
dat <- read_csv(file = "mushroom_growth.csv")

# task 2: create several plots exploring relationships between the response and predictors
# let's make growth rate our dependent variable, and play around with a few different plots
# let's try looking at growth rate based on nitrogen concentration between the two species

dat %>% 
  ggplot(aes(x = Nitrogen, y = GrowthRate)) +
  facet_grid(~Species) +
  geom_point() +
  geom_smooth(method = "lm") +
  theme_minimal()

# this plot is very interesting, the points are wild, but the "lm" curve is flat
# let's add a loess curve to see the average over increased nitrogen concentrations

dat %>% 
  ggplot(aes(x = Nitrogen, y = GrowthRate)) +
  facet_grid(~Species) +
  geom_point() +
  geom_smooth(method = "loess") +
  theme_minimal()

# ahh, much better. This curve is more consistent with the points on the graph
# let's call this p1

p1 <- dat %>% 
  ggplot(aes(x = Nitrogen, y = GrowthRate)) +
  facet_grid(~Species) +
  geom_point() +
  geom_smooth(method = "loess") +
  theme_minimal()

# let's make another plot analyzing the growth rate of another factor
# let's use light as our X axis and color by humidity

dat %>% 
  ggplot(aes(x = Light, y = GrowthRate, color = Humidity)) +
  geom_point() +
  geom_smooth(method = "lm") +
  theme_minimal()

# really clear plot! this plot has a lot we can analyze. some key observations include:
# growth rate increases with a higher humidity
# growth rate increases as the concentration of light increases in both high and low humidity
# high humidity conditions are better than low humidity conditions for growth rate with an increase in light
# let's save this as p2

p2 <- dat %>% 
  ggplot(aes(x = Light, y = GrowthRate, color = Humidity)) +
  geom_point() +
  geom_smooth(method = "lm") +
  theme_minimal()

# since p2 was very telling, let's take p2 and simply add another factor: temperature
# making a facet_grid by temperature will split p2 into two separate facets since there are only two recorded temperatures

dat %>% 
  ggplot(aes(x = Light, y = GrowthRate, color = Humidity)) +
  facet_grid(~Temperature) +
  geom_point() +
  geom_smooth(method = "lm") +
  theme_minimal()

# very interesting results
# we see that in low humidity, the temperature has almost no affect on growth rate as light increases
# we see a considerable increase in growth rate as lower temperatures in higher humidity as light increases
# let's save this as p3

p3 <- dat %>% 
  ggplot(aes(x = Light, y = GrowthRate, color = Humidity)) +
  facet_grid(~Temperature) +
  geom_point() +
  geom_smooth(method = "lm") +
  theme_minimal()

# task 3: define at least 4 models that explain the dependent variable “growthrate”
# let's try a simple linear model with nitrogen concentration as an explanatory variable

mod1 <- lm(GrowthRate ~ Nitrogen, data = dat)
summary(mod1)

# it seems to work well enough
# let's create a simple model for each of the variables

mod2 <- lm(GrowthRate ~ Temperature, data = dat)
mod3 <- lm(GrowthRate ~ Light, data = dat)
mod4 <- lm(GrowthRate ~ Humidity, data = dat)

# task 4: calculate the mean sq. error of each model

mean(mod1$residuals^2)
mean(mod2$residuals^2)
mean(mod3$residuals^2)
mean(mod4$residuals^2)

# task 5: select the best model you tried
# it seems that mod3 was the best model because it had the lowest mean-squared-error of any of the 4 models

# task 6: add predictions based on new hypothetical values for the independent variables used in your model
# let's use the add_predictions function for mod1
dat %>% 
  add_predictions(mod3) 

# looks good, let's save it as a data frame so we can work with it
df <- dat %>% 
  add_predictions(mod3) 

# let's use the select function to look at the actual vs predicted values
df %>% dplyr::select("GrowthRate","pred")

# make a new data frame with the predictor values we want to assess
newdf <- data.frame(Light = c(25, 30, 35, 40, 45, 50))

# make the predictions
pred <-  predict(mod3, newdf)

# combine the data into a new data frame
hyp_preds <- data.frame(Light = newdf$Light,
                        pred = pred)

# add a new column to clarify which data is real vs hypothetical
df$PredictionType <- "Real"
hyp_preds$PredictionType <- "Hypothetical"

# join the real data with the hypothetical data
fullpreds <- full_join(df,hyp_preds)

# task 8: plot these predictions alongside the real data
ggplot(fullpreds,aes(x=Light,y=pred,color=PredictionType)) +
  geom_point() +
  geom_point(aes(y=GrowthRate),color="Black") +
  theme_minimal()

# put all the models in a list
mods <- list(mod1=mod1,mod2=mod2,mod3=mod3,mod4=mod4)

# combine all the mods after applying the performance functions
map(mods,performance) %>% 
  reduce(full_join)

# gather residuals from all 4 models
dat %>% 
  gather_residuals(mod1,mod2,mod3,mod4) %>% 
  ggplot(aes(x=model,y=resid,fill=model)) +
  geom_boxplot(alpha=.5) +
  geom_point() + 
  theme_minimal()

# gather predictions from all 4 models
dat %>% 
  gather_predictions(mod1,mod2,mod3,mod4) %>% 
  ggplot(aes(x=Light,y=GrowthRate)) +
  geom_point(size=3) +
  geom_point(aes(y=pred,color=model)) +
  geom_smooth(aes(y=pred,color=model)) +
  theme_minimal()+
  annotate("text",x=10,y=550,label=mod1$call) +
  annotate("text",x=10,y=515,label=mod2$call) +
  annotate("text",x=10,y=480,label=mod3$call) +
  annotate("text",x=10,y=445,label=mod4$call)

# mod3 works the best, let's use the report of mod3 to finish the assignmeny
report(mod3)