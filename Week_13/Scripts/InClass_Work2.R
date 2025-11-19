###In class work 2: Models
### Madigan Boborci
### 2025-11-18


library(here)
library(tidyverse)
library(palmerpenguins)
library(broom)
library(performance) 
library(modelsummary)
library(tidymodels)
library(pandoc)
library(wesanderson)



glimpse(penguins)
##mod<-lm(y~x, data = df)

##lm = linear model, y = dependent variable, x = independent variable(s), df = dataframe.
###You read this as y is a function of x

#multiple regression
#mod<-lm(y~x1 + x2, data = df)

#interaction term
#mod<-lm(y~x1*x2, data = df) the * will compute x1+x2+x1:x2

# Linear model of Bill depth ~ Bill length by species
Peng_mod<-lm(bill_length_mm ~ bill_depth_mm*species, data = penguins)
#check assumptions
check_model(Peng_mod)


anova(Peng_mod)  #is it significant
summary(Peng_mod)  #is effect different from 0

#thank god broom
  coeffs<-tidy(Peng_mod) #gives you summary data in a cleaner format
  coeffs
  
#glance gives overall results of whole model
  results<-glance(Peng_mod)
results  

#augment gives you raw data, residuals, and fitted value
resid_fitted<-augment(Peng_mod)
resid_fitted
#####-------------------------------------------------------------------

# New model
Peng_mod_noX<-lm(bill_length_mm ~ bill_depth_mm, data = penguins)  #no interaction of species

#Make a list of models and name them
models<-list("Model with interaction" = Peng_mod,
             "Model with no interaction" = Peng_mod_noX)

#Save the results as a .docx
modelsummary(models, output = here("Week_13","Output","table.docx"))

#use canned modelplots to plot the dif
modelplot(models) +
  labs(x = 'Coefficients', 
       y = 'Term names') +
  scale_color_manual(values = wes_palette('Darjeeling1'))

#instead of using species as an interaction term, let's make an individual model for every species.
#set of lists that have each dataset that we want to model and use the map functions to run the same model to every dataset

models<- penguins %>%
  ungroup()%>% # the penguin data are grouped so we need to ungroup them-may not be case for own data
  nest(.by = species) # nest all the data by species

models

models<- penguins %>%
  ungroup()%>%  #the penguin data are grouped so we need to ungroup them-may not be case for own data
  nest(.by = species)%>% # nest all the data by species
mutate(fit = map(data, ~lm(bill_length_mm~body_mass_g, data = .)))  #fit=model

models
models$fit #shows formulas for mmodels

results<-models%>%
  mutate(coeffs=map(fit,tidy), #look at coefficients
         modelresults=map(fit, glance)) #r2 and others
results

results<-models%>%
  mutate(coeffs=map(fit,tidy), #look at coefficients
         modelresults=map(fit, glance))%>% #r2 and others
  select(species, coeffs, modelresults) %>% # only keep the results
  unnest() # put it back in a dataframe and specify which columns to unnest


view(results)

#####---------------------------------------------------------------------
#start with type of model

lm_mod<-linear_reg()%>%
  set_engine("lm")%>%  #tell engine basic linear regression model
  fit(bill_length_mm~bill_depth_mm*species, data=penguins)

lm_mod

lm_mod<-linear_reg()%>%
  set_engine("lm")%>%  #tell engine basic linear regression model
  fit(bill_length_mm~bill_depth_mm*species, data=penguins)%>%
  tidy()%>%
  ggplot()+
  geom_point(aes(x = term, y = estimate))+
  geom_errorbar(aes(x = term, ymin = estimate-std.error,
                    ymax = estimate+std.error), width = 0.1 )+
  coord_flip()
lm_mod








