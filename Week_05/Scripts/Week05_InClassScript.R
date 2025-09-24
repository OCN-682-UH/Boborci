##### This script contains work from the in person lecture of Wk 5
##### Created by:Madigan Boborci
##### Created on: 2025-09-23

##### Reaed in librarys
library(tidyverse)
library(here)
library(cowsay)

###Read in datas
EnviroData<-read_csv(here("Week_05", "Data", "site.characteristics.data.csv"))
TPCData<-read_csv(here("Week_05","Data","Topt_data.csv"))
view(EnviroData)
view(TPCData)

### Pivot data to make it match your "x" data set

EnviroData_wide <- EnviroData %>% 
  pivot_wider(names_from = parameter.measured,
              values_from = values)%>%
  arrange(site.letter)

### left join to combine datasets
FullData_left<- left_join(TPCData, EnviroData_wide)%>%
  relocate(where(is.numeric), .after = where(is.character))        #make columns in pretty order


### pivot longer and then group by site and the do summary stats
New_data<-FullData_left%>%
pivot_longer(cols= E:substrate.cover,
             names_to = "Parameters",
             values_to= "Values")%>%
  group_by(site.letter,Parameters)%>%
  summarize(Mean_vals=mean(Values, na.rm=TRUE),
  var_vals=var(Values, na.rm=TRUE))

view(New_data)

#### summarise(across(E:substrate.cover,list(mean=mean,var=var)) this for wide data

T1<-tibble(Site.ID=c("A","B", "C", "D"),
           Temperature=c(14.1, 16.7, 15.3, 12.8))

T2<-tibble(Site.ID=c("A","B", "D", "E"),
           pH = c(7.3, 7.8, 8.1, 7.9))
left_join(T1,T2)
right_join(T1,T2)
inner_join(T1,T2)
full_join(T1, T2)
semi_join(T1, T2)
anti_join(T1,T2)
say("hello", by="fish")
