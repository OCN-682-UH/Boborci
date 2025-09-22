#### This script is part 2 of the Week 4 homework
###### Created by: Madigan Boborci
###### Created on: 2025-9-19

##### libraries
library(tidyverse)
library(here)
library(readr)
library(fishualize)

#### Load in Data
ChemData <- read_csv(here("Week_04/Data/chemicaldata_maunalua.csv"))
view(ChemData)

#### Start to clean up data, do view in console after every pipeline to check

ChemData_clean<-ChemData %>%
  drop_na() %>%                                     ####Remove all NA
  separate(col=Tide_time,                           #### Change Tide_Time column into 2 separate columns
           into=c("Tide", "Time"),                  ### Name new columns
           sep="_",                                 ### identify what new columns were separated by in OG column name
           remove=FALSE) %>%                        ### Want to keep orifinal column in dataset
  filter(Site=="W") %>%                             ### select data for only site W 
  pivot_longer(cols=Temp_in:percent_sgd,            ### Use pivot longer to make all variables into one column
               names_to="Parameters",
               values_to="Values") %>%
  group_by(Parameters, Time, Season) %>%            ### select what columns to look at
  summarize(mean_vals=mean(Values,na.rm=TRUE)) %>%  ### find mean values of each parameter
  filter(Parameters != "TA",
         Parameters !="Phosphate")%>%               ###Scale was being thrown off by these parameters
   mutate(Parameters = case_when(
     Parameters=="NN"~"Nitrate/Nitrite",            #### How to change actual legend data items
     Parameters=="percent_sgd"~ "Percent SGD",
     Parameters=="Temp_in"~"Temperature (C)",
     TRUE~Parameters))
                                                   ### command+shift+m makes pipe symbol
 

####Make a plot of the mean vals for each parameter during day and night comparing Spring and Fall for Site W

ChemData_clean %>%
  ggplot(aes(x=Parameters, y=mean_vals, group = Parameters, fill=Parameters))+
  geom_histogram(stat="identity")+              ###Allows the axes to be what I determine
  facet_grid(Time~Season, scales="free")        ### Facet the graphs in Seasons and Times, shows means of each parameter for each 

#### Need to make title site W, fix x axis, fix up y axis, change color scheme 

chem_plot<- ChemData_clean %>%
  ggplot(aes(x=Parameters, y=mean_vals, group = Parameters, fill=Parameters))+      
  geom_histogram(stat="identity")+           
  facet_grid(Time~Season, scales="free")+
  scale_fill_fish_d(option = "Oxymonacanthus_longirostris")+                   ###Color scheme from fishualize package
labs(title="Comparison of Chemical Parameters Across Site W",                  
     subtitle="Mean Values of Chemical Parameters by Time of Day and Season",
     x="Chemical Parameters",
     y="Mean Values",
     caption="Data from Dr.Nyssa Silbiger collected in Hawai'i",
     color="Chemical Parameters")+
  theme_bw()+                                      
  theme(axis.title=element_text(size=15))+
  theme(plot.title=element_text(size=15,
                                face="bold"))+
  theme(axis.text.x = element_text(angle=45,hjust = 1))                     ###Angle parameter names so they don't overlap

# chem_plot

ggsave(here("Week_04", "Output","Week04_homework_02.png"),                   
       width=7, height=5)  








  
  
  
  
  