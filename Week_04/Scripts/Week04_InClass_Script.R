##### In Class Work
#### Created by: Madigan Boborci
#### Created on: 2025-9-16

#### Load Libraries

library(palmerpenguins)
library(here)
library(tidyverse)

### Load data- data set is part of library so we can just look at it

glimpse(penguins)
view(penguins)

###############################################################


#####filter for only female penguins
filter(.data=penguins, sex=="female")
###filter penguins measured in year 2008
filter(.data=penguins, year=="2008")
###filter penguins heavier than 5000 g
filter(.data=penguins, body_mass_g>"5000")

###Boolean Operations:  a&b= and a|b= or 

###These two things are the same 
filter(.data=penguins, sex=="female", body_mass_g>5000)
filter(.data=penguins, sex=="female"& body_mass_g>5000)

###########################################################

##### Penguins collected in either 2008 or 2009
filter (.data=penguins, year==2008|year==2009)

##### Penguins not collected from island Dream
filter (.data=penguins, island != "Dream")

#### Species Adelie and Gentoo
filter (.data=penguins, species %in% c("Adelie","Gentoo"))

################################################################

######## make a new column looking for mass in kg instead of g

data2<-mutate(.data=penguins,
       body_mass_kg=body_mass_g/1000)

######## check it out
view(data2)

#### convert g to kg and add a ratio of bill depth to bill length
data2<-mutate(.data=penguins,
              body_mass_kg=body_mass_g/1000,
              bill_length_depth=bill_length_mm/bill_depth_mm)
view(data2)


###### add flipper length and body mass together
mutate(.data=penguins,
       body_size=body_mass_g+flipper_length_mm)

##### body mass greater and less than 4000
data2<-mutate(.data=penguins,
       size_bin= ifelse(body_mass_g>4000,"Big", "Small"))

#### filter out female penguins and add column for log body mass

penguins %>%  ###use penguin dataframe
  filter(sex=="female") %>%  ###select females
  mutate(log_mass=log(body_mass_g)) ###new column for log body mass
  
##### select certain columns for new data frame using select
penguins %>%      ###use penguin dataframe
  filter(sex=="female") %>%     ###select females
  mutate(log_mass=log(body_mass_g)) %>%  ###new column for log body mass
  select(species,island,sex,log_mass)
##### change column names with select(New, New, New= old, old, old)


#### Summary stats

penguins %>%
  summarise(mean_flipper= mean(flipper_length_mm, na.rm=TRUE))


#### Make groups

penguins %>% 
  group_by(island)%>%###group by what- can be multiple (island,sex)
  summarise(mean_bill=mean(bill_length_mm, na.rm=TRUE),
            max_bill=max(bill_length_mm, na.rm=TRUE))


### drop_na(sex) will drop ALL ROWS where sex is missing data
### and you can pipe straight into ggplot
penguins %>%
  drop_na(sex) %>%
  ggplot(aes(x = sex, y = flipper_length_mm)) +      #### once in ggplot land have to use ggplot language (+ not pipes)
  geom_boxplot()


