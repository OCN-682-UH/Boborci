### In Class Work week 7
### Created by: Madigan Boborci
### Created on 2025-10-7
###########################################################

# Load libraries
library(tidyverse)
library(here)
library(maps)
library(mapdata)
library(mapproj)
library(ggmap)

# Read in data
  popdata<-read.csv(here("Week_07","Data","CAPopdata.csv"))  # CA population by county data
  stars<-read_csv(here("Week_07","Data","stars.csv"))        # Seastars at different field sites
  
# Look at data
  View(popdata)
  View(stars)
  
#load base map with map_data
  world<-map_data("world")
head (world)
usa<- map_data("usa")
head(usa)
italy<-map_data("italy")
head(italy)

states<-map_data("state")
head(states)
counties<-map_data("county")
head(counties)



# group=important shows ggplot when to stop conencting certain dots


ggplot()+
  geom_polygon(data=world, aes(x=long,y=lat, group=group),color="black")      #color go outside aes

ggplot()+
  geom_polygon(data=world, aes(x=long,y=lat, group=group, fill=region),color="black")+     #fill go inside beacuse its mapped with the data, can make background blue for the ocean
  guides(fill=FALSE)+
  theme(panel.background= element_rect(fill = "lightblue"))+      #can make background blue for the ocean
  coord_map(projection="mercator",
            xlim=c(-180,180))           #can chage projection for map-example with mercator



ggplot()+
  geom_polygon(data=world, aes(x=long,y=lat, group=group, fill=region),color="black")+     #fill go inside beacuse its mapped with the data, can make background blue for the ocean
  guides(fill=FALSE)+
  theme(panel.background= element_rect(fill = "lightblue"))+      #can make background blue for the ocean
  coord_map(projection="sinusoidal",
            xlim=c(-180,180))                 #different map projection


###. Find California
CA_data<-states %>%
  filter(region == "california")

ggplot()+
  geom_polygon(data=CA_data, aes(x=long,y=lat, group=group),fill="black")+
  coord_map()+
  theme_void()
  
###get pop data by county sorted

head(counties)     #counties are subregions
head(popdata)     #change counties to subregions

#need to edit data to join it together

CApop_county<-popdata%>%
  select("subregion"=County, Population)%>%     #change column names
  inner_join(counties)%>%
  filter(region=="california")        #make sure only pulling CA counties


head(CApop_county)

ggplot()+
  geom_polygon(data=CApop_county, 
               aes(x=long,y=lat, group=group, fill=Population),  
color="black")+
  coord_map()+
  theme_void()+
  scale_fill_gradient(trans="log10")    #transform to make colors better


head(stars) # number sea stars per m2 in CA

#add point layer of star data in

ggplot()+
  geom_polygon(data=CApop_county, 
               aes(x=long,y=lat, group=group, fill=Population),  
               color="black")+
  geom_point(data=stars,
             aes(x=long, y=lat,))+   #Add seastar data
  coord_map()+
  theme_void()+
  scale_fill_gradient(trans="log10")


## make point size match star count

ggplot()+
  geom_polygon(data=CApop_county, 
               aes(x=long,y=lat, group=group, fill=Population),  
               color="black")+
  geom_point(data=stars,
             aes(x=long, y=lat, size=star_no))+   #make points >in size with > star count
  coord_map()+
  theme_void()+
  scale_fill_gradient(trans="log10")+
  labs(size = "# stars/m2")     #better legend
ggsave(here("Week_07","Output","CApop.pdf"))






