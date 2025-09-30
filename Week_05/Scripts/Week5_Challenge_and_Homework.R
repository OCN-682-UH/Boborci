#### This script is for the challenge assignment and the homework assignment 
#### Created by: Madigan Boborci
#### Created on: 2025-09-23

###load libraries###
library(here)
library(tidyverse)
library(lubridate)
library(fishualize)

###Read in data
CondData<-read_csv(here("Week_05", "Data", "CondData.csv"))
View(CondData)
glimpse(CondData)

DepthData<-read_csv(here("Week_05", "Data", "DepthData.csv"))
View(DepthData)
glimpse(DepthData)

### This shows Depth date column is already in dttm format, so no need to convert


####Challenge assignment
Cond_Data<-CondData%>%
  mutate(date=mdy_hms(date))

View(Cond_Data)
glimpse(Cond_Data)

###### Now both datasets have a Date column in dttm format 

#########HOMEWORK BEGIN##########
###Round cond data to nearest 10 s so it matches the depth data

Cond_Data<-CondData%>%
  mutate(date=mdy_hms(date))%>%                             #### line that made it a dttm
  mutate(date= round_date(date, "10 secs"))                 #### rounding to 10 s

### join datasets together by what they both share-inner join
########## want to take averages of date, depth, temperature, and salinity by minute

Ave_Data<-inner_join(Cond_Data, DepthData)%>%                             ### New dataframe for joined data                
  mutate(minute_interval = floor_date(date, unit = "minute"))%>%          ### changes time to be at minutee intervals, floor rounds to nearest minute 
  group_by(minute_interval)%>%                                           ### group by minute and then take averages so you get an average for the whole minute
  summarise(ave_depth=mean(Depth),
            ave_temp=mean(Temperature),                                    #### Averages
            ave_salinity=mean(Salinity))%>%

write_csv(here("Week_05", "Output", "average_data.csv"))                  ### Save csv file


####Think I want to pivot longer to be able to plot all the parameters at once

Data_long<-Ave_Data%>%
  pivot_longer(cols=ave_depth:ave_salinity,            ### Use pivot longer to make all variables into one column
               names_to="Ave_Measurements",
               values_to="Values")%>%
  filter(Ave_Measurements != "ave_depth")%>%        ### don't want this in my plot
  mutate(Ave_Measurements= case_when(
    Ave_Measurements=="ave_salinity"~"Average Salinity (PSU)",            #### How to change actual legend data items
    Ave_Measurements=="ave_temp"~ "Average Temperature (ºC)"))



HW_Plot<- Data_long%>%
  ggplot(aes(x=minute_interval, y=Values, group=Ave_Measurements, color=Ave_Measurements))+
  geom_point()+
  scale_colour_fish(discrete=TRUE, option = "Scarus_ghobban", direction = 1)+
  geom_smooth()+
  labs(title="Average Values Over Time",                  
       subtitle="Mean Values per minute of Salinity and Temperature",
       caption="Data from Jan 15 2021",
       x="Time (minute intervals)",
       y="Mean Values per Minute",
       color="Parameters")+
  theme_bw()+                                      
  theme(axis.title=element_text(size=15))+
  theme(plot.title=element_text(size=15,
                                face="bold"))

ggsave(here("Week_05", "Output","Week05_homework.png"),                   
       width=7, height=5)  



