###### This is the first homework assignment
###### Created by: Madigan Boborci
###### Created on: 2025-09-16

######## libraries
library(palmerpenguins)
library(tidyverse)
library(here)
library(ggthemes)
library(devtools)
library(NatParksPalettes)
library(fishualize)

##### Data is in package already
view(penguins)

###Write a script that: calculates the mean and variance of body mass by species, island, and sex without any NAs
###filters out (i.e. excludes) male penguins, then calculates the log body mass, then selects only the columns for species, island, sex, and log body mass, then use these data to make any plot. Make sure the plot has clean and clear labels and follows best practices. Save the plot in the correct output folder.


###Question 1###

penguin_body_mass<-penguins %>% 
  group_by(species,island,sex)%>% ###group by what- species, island, sex
  drop_na(species,island,sex)%>%  ###don't want any NA in any column
  summarise(mean_body=mean(body_mass_g, na.rm=TRUE),    ####mean and variance of body mass
            var_body=var(body_mass_g, na.rm=TRUE))

view(penguin_body_mass)
##########################################

###Question 2###

penguin_clean<-penguins %>%      ###use penguin dataframe
  filter(sex=="female") %>%     ###select females
  mutate(log_mass=log(body_mass_g)) %>%  ###new column for log body mass
  select(species,island,sex,log_mass)  %>%
  drop_na(species,island,sex,log_mass)

view(penguin_clean)  

###Make plot of log body mass  for females by species per island?
ggplot(data=penguin_clean, mapping=aes(x=species,
                                       y=log_mass,
                                       group=species,
                                       fill=species))+
  facet_wrap(~island)+
geom_boxplot()+
  geom_jitter(alpha=0.4)

###Why do I hate it ###

### ok what about facet wrap the island, do log female body size per species in bar plot?

ggplot(data=penguin_clean,
       mapping=aes(x=species,
                   y=log_mass,
                   fill=species))+
  facet_wrap(~island)+
  geom_bar(stat="identity")        ###Apparently this is how you make R use your variables instead of count
  
### Ok I hate it less- make it prettier
ggplot(data=penguin_clean,
mapping=aes(x=species,
            y=log_mass,
            fill=species))+
  facet_wrap(~island)+
  geom_bar(stat="identity")+
  scale_fill_fish_d(option = "Naso_lituratus")
  

####n Okay back to the boxplot
ggplot(data=penguin_clean, mapping=aes(x=species,
                                       y=log_mass,
                                       group=species,
                                       fill=species))+
  facet_wrap(~island)+
  geom_boxplot()+
  geom_jitter(alpha=0.4)+
  scale_fill_fish_d(option = "Naso_lituratus")
  
####I hate it less now and it shows the Adelie variations that are small a little better

ggplot(data=penguin_clean, mapping=aes(x=species,
                                       y=log_mass,
                                       group=species,
                                       fill=species))+
  facet_wrap(~island)+
  geom_boxplot()+
  geom_jitter(alpha=0.4)+
  scale_fill_fish_d(option = "Naso_lituratus")+
  labs(title="Log of Penguin Body Mass Across Islands",
       subtitle="Female Penguinn Bodymass of each species across three islands",
       x="Species",
       y="Log Body Mass",
       fill="Species",
       caption="Data from the palmerpenguins package from the Palmer LTER")+
  theme_clean()+
  theme(axis.title=element_text(size=15,
                                color="darkblue",))+
  theme(plot.title=element_text(size=15,
                                color="darkblue",
                                face="bold"))
ggsave(here("Week_04", "Output","Week04_homework_01.png"),
       width=7, height=5)  

















