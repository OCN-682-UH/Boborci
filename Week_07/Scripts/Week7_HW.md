# Week 7 Homework
Madigan Boborci

\##Introduction This Quarto doc is to do the first part of the homework:
making a map with some **Tiny Tuesday** data

``` r
#load libraries

#| warning: false
#| messgae: false
library(tidyverse)
```

    ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
    ✔ dplyr     1.1.4     ✔ readr     2.1.5
    ✔ forcats   1.0.0     ✔ stringr   1.5.1
    ✔ ggplot2   3.5.2     ✔ tibble    3.3.0
    ✔ lubridate 1.9.4     ✔ tidyr     1.3.1
    ✔ purrr     1.1.0     
    ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ✖ dplyr::filter() masks stats::filter()
    ✖ dplyr::lag()    masks stats::lag()
    ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

``` r
library(here)
```

    here() starts at /Users/madiganboborci/Desktop/Repositories/Boborci

``` r
library(maps)
```


    Attaching package: 'maps'

    The following object is masked from 'package:purrr':

        map

``` r
library(mapdata)
library(mapproj)
library(ggmap)
```

    ℹ Google's Terms of Service: <https://mapsplatform.google.com>
      Stadia Maps' Terms of Service: <https://stadiamaps.com/terms-of-service>
      OpenStreetMap's Tile Usage Policy: <https://operations.osmfoundation.org/policies/tiles>
    ℹ Please cite ggmap if you use it! Use `citation("ggmap")` for details.

``` r
library(tidytuesdayR)
```

``` r
#Read in data 
#| warning: false
#| messgae: false

tuesdata <- tidytuesdayR::tt_load('2022-09-13')
```

    ---- Compiling #TidyTuesday Information for 2022-09-13 ----
    --- There is 1 file available ---


    ── Downloading files ───────────────────────────────────────────────────────────

      1 of 1: "bigfoot.csv"

``` r
tuesdata <- tidytuesdayR::tt_load(2022, week = 37)
```

    ---- Compiling #TidyTuesday Information for 2022-09-13 ----
    --- There is 1 file available ---


    ── Downloading files ───────────────────────────────────────────────────────────

      1 of 1: "bigfoot.csv"

``` r
bigfoot <- tuesdata$bigfoot
```

``` r
#Look at data
View(bigfoot)
```

\##Data Analysis I want to see where Bigfoot sightings have occurred by
county and state across the US. I need to  
- make a map of the US  
- change the data so the column county matches  
- join the data  
- overlay the sightings as a point layer? or heat map?  
- make map pretty

### Make first map of US

``` r
#|message: false
#|warning: false

states<-map_data("state")
head(states)
```

           long      lat group order  region subregion
    1 -87.46201 30.38968     1     1 alabama      <NA>
    2 -87.48493 30.37249     1     2 alabama      <NA>
    3 -87.52503 30.37249     1     3 alabama      <NA>
    4 -87.53076 30.33239     1     4 alabama      <NA>
    5 -87.57087 30.32665     1     5 alabama      <NA>
    6 -87.58806 30.32665     1     6 alabama      <NA>

``` r
ggplot()+
  geom_polygon(data=states, aes(x=long,y=lat, group=group, fill=region),color="black")+
  guides(fill=FALSE)+
  coord_map()+
  theme_void()
```

    Warning: The `<scale>` argument of `guides()` cannot be `FALSE`. Use "none" instead as
    of ggplot2 3.3.4.

![](../Output/unnamed-chunk-4-1.png)

### Figure out how to fix up this bigfoot data

``` r
#only care about state and county, lat and long
bigfoot_clean<-bigfoot%>%
  drop_na()%>%
  select(county,state,latitude,longitude)
View(bigfoot_clean)
```

### 

### Make data have counties instead of subregions

Bigfoot_county\<-bigfoot%\>% select(“subregion”=County)%\>% \#change
column names inner_join(counties)%\>% filter(region==“california”)
