#### This script is for the online lecture on lubridate
#### Created by: Madigan Boborci
#### Created on: 2025-09-23

#### Load Libraries
library(tidyverse)
library(here)
library(lubridate)


### Play with lubridate

###What time is it now?
now()

### Different time zone 
now(tzone="EST")

### is it morning?
am(now())

###These will all give same output, always put in quotes 
###Want to be a character

ymd("2021-02-24")
mdy("February 24 2021")
dmy("24/02/2021")

### Date and time specifications 
ymd_hms("2021-02-24 10:22:20 PM")
mdy_hm("February 24 2021 10:22 PM")
mdy_hms("02/24/2021 22:22:20")


### make a vector of dates
datetimes<-c("02/24/2021 22:22:20",
             "02/25/2021 11:21:10",
             "02/26/2021 8:01:52")
###convert to datetimes
datetimes <- mdy_hms(datetimes)

###see what month they in

month(datetimes)

### make months into their month names
month(datetimes, label = TRUE)

### make the months spelled out
month(datetimes, label = TRUE, abbr = FALSE)

### Extract the days
day(datetimes)                 ###date number
wday(datetimes, label = TRUE)  ### Week day

hour(datetimes)                ###can do with minute or second

### can add time NEED THE S IN HOURS
datetimes + hours(4) 

### can add days as well-NEED S
datetimes+ days(2)

### round to nearest minute interval 
round_date(datetimes, "minute")
round_date(datetimes, "10 mins")





















