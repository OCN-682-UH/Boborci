### This is my header. I am learning how to import data and organize my repositories
### Created by: Madigan Boborci
### Created on 2025-09-03
#################################
### Load Libraries ###
library(tidyverse)
library(here)
### Reas in da data###
WeightData<-read_csv(here("Week_02","Data", "weightdata.csv"))
### Analyze ###
head(WeightData) ###shows top 6 lines of data set 
tail(WeightData) ###shows bottom 6 lines
view(WeightData) ###shows whole data set
