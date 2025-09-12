### This is my homework script
### Created by: Madigan Boborci
### Created on: 2025-09-10
#############################################################

### Load ze libraries ###
library(palmerpenguins)
library(here)
library(tidyverse)
library(ggthemes)
library(devtools)
library(NatParksPalettes)

#### Ze data is already in the package, don't need to load in separately##

### Give the data a glance###
glimpse(penguins)

### Let's do ze analysis ###

ggplot(data=penguins,
       mapping=aes(x=species,
                   y=body_mass_g,
                   group=species,
                   color=species))+
  geom_violin()+
  facet_wrap(~sex,
             ncol(3))+
  geom_jitter(mapping=aes(alpha=0.2,
                          show.legend=FALSE,
                          color=species))+
coord_cartesian(ylim(c=(0, 5500)))
  
  
####have to leave- can I facet this to have one per species and then overlay trend of flipper length?####

