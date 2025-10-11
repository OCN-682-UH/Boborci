### Libraries
library(ggmap)
library(tidyverse)
library(here)
library(ggspatial)
library(emojifont)

##read in data
ChemData<-read_csv(here("Week_07", "Data","chemicaldata_maunalua.csv"))
glimpse(ChemData)


##using ggmap
Oahu<-get_map("Oahu") #pulls coords/data for map
ggmap(Oahu) #actually makes basemap plot


WP<-data.frame(lon=-157.7621, lat=21.27427) #Put in coords for Wailupe- makes center of map
Map1<-get_map(WP) #pulls coords
ggmap(Map1) #maps baselayer
 

#zoom argument goes 3 (hella zoomed out) to 20 (v zoomed in)

Map1<-get_map(WP, zoom=17)
ggmap(Map1)

#Convert into satellite

Map1<-get_map(WP, zoom=17, maptype="satellite")
ggmap(Map1)

#more fun map types

Map1<-get_map(WP, zoom=17, maptype="stamen_watercolor",spurce="stadia")
ggmap(Map1)

# Now want to use map as a baselayer for plot 
Map1<-get_map(WP, zoom=17, maptype="satellite")

ggmap(Map1)+
  geom_point(data=ChemData, 
             aes(x=Long, y=Lat, color=Salinity),  #Use col names in ChemData set
             size=3)+
  scale_color_viridis_c()+
  annotation_scale(bar_cols=c("black","white"),
                   location="bl")+ #puts scale bar in bottom left
  annotation_north_arrow(location="tl")+ #puts direction arrow top left
  coord_sf(crs=4326) #GPS coordinate reference system- this is typical but depends on gps



#will give you the lat and long of known places
geocode("UCSB")



#emoji package 

search_emoji('hockey')

ggplot()+
  geom_emoji('field_hockey', x=1:5,y=1:5,size=7)






