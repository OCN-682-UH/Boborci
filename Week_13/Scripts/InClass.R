### In class work for week 13 on iterative coding
### Madigan Boborci
### 2025-11-18

library(here)
library(tidyverse)



print(paste("The year is", 2000))
#make a for loop 
#sequence is what you want repeated
#for loop has sequence in it
  #index=i, or idx or whatever
years<-c(2015:2021)


for(i in years){     #set up loop where i is the index
  print(paste("The year is", i))  #loop over i
}
#can test forloop by setting i= 2017 or whatever in the console, and then run just the print line of the forloop and see if it prints right
  

#need to preallocate space in R for forloop to go
#make empty matrix that is as long as years vector

year_data<-tibble(year =  rep(NA, length(years)),  # column name for year
                  year_name = rep(NA, length(years))) # column name for the year name
year_data


#bracketed i makes it like position 1,(2015), 2 (2016) eetc
for (i in 1:length(years)){ # set up the for loop where i is the index
  year_data$year_name[i]<-paste("The year is", years[i]) # loop over i
}
year_data

for(i in 1:length(years)){ # set up the for loop where i is the index
  year_data$year_name[i]<-paste("The year is", years[i]) # loop over year name
  year_data$year[i]<-years[i] # loop over year- puts the year in the first column
}
year_data


#DATA:
testdata<-read_csv(here("Week_13", "Data", "cond_data","011521_CT316_1pcal.csv"))
glimpse(testdata)

CondPath<-here("Week_13", "Data","cond_data")
#use regex to find csv files
files<-dir(path=CondPath, pattern=".csv") #could specify site etc wtih regex pattern
files
 #now ned to allocate space
  #want column for filename,temp, sal
cond_data<-tibble(filename =  rep(NA, length(files)),  # column name for year
                  mean_temp = rep(NA, length(files)), # column name for the mean temperature
                  mean_sal = rep(NA, length(files))) # column name for the mean salinity 

cond_data

#testing
raw_data<-read_csv(paste0(CondPath,"/", files[1]))
head(raw_data)


#Write basic code to find a mean
mean_temp<-mean(raw_data$Temperature, na.rm = TRUE) # calculate a mean
mean_temp    #should be mean of first file


for (i in 1:length(files)){           
  raw_data<-read_csv(paste0(CondPath,"/",files[i]))
  glimpse(raw_data)     #still haven't saved anything-checking it works
}


for (i in 1:length(files)){           
  raw_data<-read_csv(paste0(CondPath,"/",files[i]))
  #glimpse(raw_data)  
  cond_data$filename[i]<-files[i]    #calls empty dataframe and should add the filenames
  cond_data$mean_temp[i]<-mean(raw_data$Temperature, na.rm=TRUE)
  cond_data$mean_sal[i]<-mean(raw_data$Salinity, na.rm=TRUE)
}

cond_data




#Now do same basic thing in tidyR

1:10 %>% # a vector from 1 to 10 (we are going to do this 10 times) %>% # the vector to iterate over
  map(rnorm, n = 15) %>% # calculate 15 random numbers based on a normal distribution in a list
  map_dbl(mean) #calculate mean from each list we made-makes vector

#OR use own function

1:10%>%
  map(function(x) rnorm(15,x))%>%
  map_dbl(mean)

#OR use a formula when you want to change arguments
1:10%>%
  map(~ rnorm(15, .x))%>%
  map_dbl(mean)



#take files from earlier 
files
#map needs full file name
files<- dir(path=CondPath, pattern=".csv", full.names=TRUE)  #save full path name
files

data<-files %>%
  set_names()%>% # set's the id of each list to the file name
  map_df(read_csv,.id = "filename") # map everything to a dataframe and put the id in a column called filename-our function is read_csv
data
#group by filename and use summarise for temp and sal


data<-files %>%
  set_names()%>% # set's the id of each list to the file name
  map_df(read_csv,.id = "filename")%>%
  group_by(filename) %>%
  summarise(mean_temp = mean(Temperature, na.rm = TRUE),
            mean_sal = mean(Salinity,na.rm = TRUE))
data














