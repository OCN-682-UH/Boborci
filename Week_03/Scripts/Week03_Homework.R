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
                   y=flipper_length_mm,                      ###Choosing to look at Flipper length by species##
                   group=species,
                   fill=species))+
  geom_violin(trim=FALSE)+                                   ### violin plot, mostly because I haven't done one before. The trim part makes the plot taper at the ends ###
  scale_fill_manual(values=natparks.pals("Glacier", 3))+     ### Using Glacier NP colors- as penguin-y as I could get###       
  geom_jitter(alpha=0.4)+                                    ### Also overlaying a jitter of the raw data to make sure it all looks pretty accurate ###
  coord_cartesian(ylim=c(150, 250))+                          ### Set lengths to be from 150-250 mm to see more solid distributions ###

#####Now making everything look nicer###
  
  labs(title="Examining Penguin Flipper Length by Species",
       subtitle="Fin length distributions among Adelie, Chinstrap, and Gentoo Penguins",
       x="Species",
       y="Flipper Length (mm)",
       fill="Species",
       caption="Data from the palmerpenguins package from the Palmer LTER")+
theme_clean()+
  theme(axis.title=element_text(size=15,
                                color="darkblue",))+
  theme(plot.title=element_text(size=15,
                                color="darkblue",
                                face="bold"))
ggsave(here("Week_03", "Output","penguin_homework.png"),
       width=7, height=5)  
  


