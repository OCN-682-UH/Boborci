####This is the homework for Week 3
### Created by: Madigan Boborci
### Created on: 2025-09-09
#############################################
  ### to install devtool packages-type devtools::install_github("username/packagename")
#####Load da Libraries####
libary(palmerpenguins)
library(tidyverse)
library(here)
library(beyonce)
library(ggthemes)

### Data in package, don't need to read in###

### Check on the Data ###
glimpse(penguins)
view(penguins)

#### Let's get into some plotsssss ###

ggplot(data=penguins,
       mapping=aes(x=bill_dep,
                   y=bill_len,
                   group=species,
                   color=species))+
  geom_point()+
  geom_smooth(method="lm")+                  #Adds best fit line, can make a linear model that does a linar regression
  labs(x="Bill Depth (mm)",
       y="Bill Length (mm)")+
  scale_color_viridis_d()+
  scale_x_continuous(limits= c(0,20))+        #When using vector, need the c
  scale_y_continuous(limits= c(0,50))

######copying previous code to start using breaks etc#######

ggplot(data=penguins,
       mapping=aes(x=bill_dep,
                   y=bill_len,
                   group=species,
                   color=species))+
  geom_point()+
  geom_smooth(method="lm")+                  
  labs(x="Bill Depth (mm)",
       y="Bill Length (mm)")+
  scale_color_viridis_d()+
  scale_x_continuous(breaks=c(14,17,21),                           ### using to set specific points of interest
                     labels=c("low","medium","high"))+             ##using to label those points instead of just numbers
  scale_color_manual(values= beyonce_palette(2))+ #### want to specify what colors they are ourselves
  coord_fixed()                                    ## flips fixes, etc x and y coords

### use diaminds data to look at coord trans
ggplot(diamonds, aes(carat,price))+
  geom_point()+
  coord_trans(x="log10",                           ### transforms the visual not the actual data
              y="log10")

 
###Theme controls non data elements###
###penguin data recopied in to do theme things

ggplot(data=penguins,
       mapping=aes(x=bill_dep,
                   y=bill_len,
                   group=species,
                   color=species))+
  geom_point()+
  geom_smooth(method="lm")+                  
  labs(x="Bill Depth (mm)",
       y="Bill Length (mm)")+
  scale_color_viridis_d()+
  scale_x_continuous(breaks=c(14,17,21),                           
                     labels=c("low","medium","high"))+             
  scale_color_manual(values= beyonce_palette(2))+ 
  theme_bw()+
  theme(axis.title = element_text(size=20,
                                  color="darkblue"),
        panel.background=element_rect(fill="linen"),
        axis.line=element_line(color="darkgrey"))

ggsave(here("Week_03", "Output","peguin.png"),
       width=7, height=5)

  