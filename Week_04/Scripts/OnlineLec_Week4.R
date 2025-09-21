#### This script is for working on the online lecture and learning tidyr
###### Created by: Madigan Boborci
###### Created on: 2025-9-19

##### libraries
library(tidyverse)
library(here)
library(readr)

#### Load in Data
ChemData <- read_csv(here("Week_04/Data/chemicaldata_maunalua.csv"))
view(ChemData)


### Want to get rid of NAs

ChemData_clean<-ChemData %>%
  filter(complete.cases(.))    ###filters out any rows that aren't complete ~ Drop NA
view(ChemData_clean)

###Want to split up the TideTime column- use separate
ChemData_clean<-ChemData %>%
  filter(complete.cases(.)) %>%
  separate(col=Tide_time,                      ####choose column
           into=c("Tide", "Time"),             ####separate into
           sep="_")                           #####separate by
                                              ### could use remove=FALSE and keep orig
 glimpse(ChemData_clean)      
 
#### Can also mesh two columns together, like zone and site-use unite
 
 ChemData_clean<-ChemData %>%
   filter(complete.cases(.)) %>%
   separate(col=Tide_time,                      
            into=c("Tide", "Time"),             
            sep="_") %>%
       unite(col="Site_Zone",                 ####col is now name of new column
         c(Site,Zone),                      ###names of columns from og data
         sep=".",                           ###use a period between them
         remove=FALSE)                      ###keep orig column in the data
glimpse(ChemData_clean)

 
##### long data format makes using group by function easier

ChemData_long<-ChemData_clean %>%
  pivot_longer(cols=Temp_in:percent_sgd,    ####all columns we want to pivot
               names_to = "Variables",      ### name of new column of all the dif variables you just pivoted
               values_to = "Values")        ### name of new column holding all the variable values
view(ChemData_long)                 

####Calculate mean and variance for all parameters at each site                 
 
ChemData_long %>%
  group_by(Variables,Site) %>%                    #group by everything we want
  summarise(Param_means=mean(Values, na.rm=TRUE),  #get means
            Param_vars=var(Values,na.rm=TRUE))     #get variance
  
 
 ##### Calculate mean, var, and standard deviation for all Variables by site, zone and tide

 ChemData_long %>%
   group_by(Variables, Site, Zone, Tide) %>%
   summarise(Param_means=mean(Values, na.rm=TRUE),
             Param_vars=var(Values, na.rm=TRUE),
             Param_sd=sd(Values,na.rm=TRUE))
 
 #### make a boxplot of raw values on y and site on x, facet wrap as a function of variable 
 ChemData_long %>%
   ggplot(aes(x=Site, y=Values))+
   geom_boxplot()+
   facet_wrap(~Variables, scales= "free")         ####allows axes to be independently generated, can do with x y or both
 
 
#### Can also make data wider if you don't want long data
 
 ChemData_wide<- ChemData_long %>%
   pivot_wider(names_from=Variables,             #### use from to extract the variables from one column and make them each their own
               values_from=Values)
view(ChemData_wide)   
 
 #### Now make a clean data set so we can export the csv, same steps and annotations as above just all piped together

ChemData_clean<-ChemData %>%
  drop_na() %>%
  separate(col=Tide_time,                      
           into=c("Tide", "Time"),             
           sep="_",
           remove=FALSE) %>%
  pivot_longer(cols=Temp_in:percent_sgd,
               names_to="Variables",
               values_to="Values") %>%
  group_by(Variables, Site, Time) %>%
  summarise(mean_vals= mean(Values, na.rm=TRUE)) %>%
  pivot_wider(names_from=Variables,
              values_from= mean_vals)%>%                   ###want to widen the data to make it look better
  write_csv(here("Week_04", "Output", "summary.csv"))      ###export as csv file
  

 
 










      