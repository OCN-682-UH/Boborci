### This is the in class work for Week 3 
### Created by: Madigan Boborci
#### Created on: 2025-09-09
############################################################################

#### Load Libraries####
library(palmerpenguins)
library (tidyverse)

#### Data in lib, don't need to read in####

##### Take some peeks at dis data###
glimpse(penguins)
head(penguins)

####Actually do some analyses###
ggplot(data=penguins,
       mapping=aes(x= bill_dep, ###this is where you change all aesthetics, including color###
                   y= bill_len,
                   color=species))+
  geom_point()+
  ###labs changes all labels###
  labs(title="Bill Depths and Lengths",
       subtitle= "Measurements for Adelie, Chinstrap, and Gentoo Penguins",
       x="Bill Depth (mm)",
       y= "Bill Length (mm)",
       color="Species",       ###Use colors to call back to the aes, but to edit legend of those colors###
       caption="Source:Palmer Station LTER/palmerpenguins package")+
  scale_color_viridis_d()     ### not in labs, enter color blind friendly color scheme###
### Setting is not mapping- affects things that aren't attached or influenced by the data####
ggplot(data=penguins,
       mapping=aes(x= bill_dep, 
                   y= bill_len,
                   color=species))+
  geom_point(size=2, alpha=0.5)+
  labs(title="Bill Depths and Lengths",
      subtitle= "Measurements for Adelie, Chinstrap, and Gentoo Penguins",
      x="Bill Depth (mm)",
      y= "Bill Length (mm)",
      color="Species",  
      caption="Source:Palmer Station LTER/palmerpenguins package")+
  scale_color_viridis_d()  
####### facets#####
ggplot(data=penguins,
       mapping=aes(x= bill_dep, 
                   y= bill_len))+
  geom_point()+
  facet_grid(species~sex) ####(rows~columns)

## or facet wrap it
ggplot(data=penguins,
       mapping=aes(x= bill_dep, 
                   y= bill_len))+
  geom_point()+
  facet_wrap(~ species)
### can add color too
ggplot(data=penguins,
       mapping=aes(x= bill_dep, 
                   y= bill_len,
                   color=species))+
  geom_point()+
  facet_grid(species~sex)+
  guides(color=FALSE) ###don't need legend because rows and columns already labelled##



