### Script for Week 10 class work
### Madigan Boborci

#Libraries
library(here)
library(tidyverse)
library(palmerpenguins)
library(PNWColors)

#Work
df<-tibble(
  a=rnorm(10),
  b=rnorm(10),
  c=rnorm(10),
  d=rnorm(10)
)
head(df)


#to scale data normally 
df<-df %>%
  mutate(a = (a-min(a, na.rm = TRUE))/(max(a, na.rm = TRUE)-min(a, na.rm = TRUE)))
head(df)

#would have to do for all individual columns a-d
#make function instead

#make rescaling function
rescale01 <- function(x) {         #pick a name-this rescales to values between 0-1 for ex, then list arguments-in this case only one
  value<-(x-min(x, na.rm = TRUE))/(max(x, na.rm = TRUE)-min(x, na.rm = TRUE))    
  return(value)   #returns the value you want user to see^ as named above
} #body of function is in the curly brackets

df %>%
  mutate(a = rescale01(a),     #put function in the mutate
         b = rescale01(b),
         c = rescale01(c),
         d = rescale01(d))

#OR use mutate all and do at once

df %>%
  mutate_all(rescale01)


# make a function to convert F to C

temp_C <- (temp_F - 32) * 5 / 9

#name function
fahrenheit_to_celsius<- function(){   
  temp_C <- (temp_F - 32) * 5 / 9       #here input if F and return is the C, so put them in their spots
return()}


fahrenheit_to_celsius<- function(temp_F){   
  temp_C <- (temp_F - 32) * 5 / 9       #here input if F and return is the C, so put them in their spots
  return(temp_C)}

#put functions up at beginning like libraries so that they apply to whole script

fahrenheit_to_celsius(32)


#make function for Celsius to Kelvin (K=celsius+273.15)
C_to_K<- function(temp_C){
  temp_K<-(temp_C+273.15)
  return(temp_K)}
C_to_K(0)

#turn plot into function

pal<-pnw_palette("Lake",3, type = "discrete") # my color palette 
ggplot(penguins, aes(x = body_mass_g, y = bill_length_mm, color = island))+
  geom_point()+
  geom_smooth(method = "lm")+ # add a linear model
  scale_color_manual("Island", values=pal)+   # use pretty colors and another example of how to manually change the legend title for colors
  theme_bw()

#name and set up function
myplot<-function(){
  pal<-pnw_palette("Lake",3, type = "discrete") # my color palette 
  ggplot(penguins, aes(x = body_mass_g, y = bill_length_mm, color = island))+
    geom_point()+
    geom_smooth(method = "lm")+ # add a linear model
    scale_color_manual("Island", values=pal)+   # use pretty colors and another example of how to manually change the legend title for colors
    theme_bw()
}

#but let's make it flexible so we can change the x and y and what the colors need to be

myplot<-function(data,x ,y ){
  pal<-pnw_palette("Lake",3, type = "discrete") # my color palette 
  ggplot(data, aes(x = x, y = y, color = island))+    #as of rn color is still set to island
    geom_point()+
    geom_smooth(method = "lm")+ # add a linear model
    scale_color_manual("Island", values=pal)+   # use pretty colors and another example of how to manually change the legend title for colors
    theme_bw()
}

myplot(data = penguins, x = body_mass_g, y = bill_length_mm)
#you get an error
#rlang made a "curly-curly" that lets you assign variables that are column names in dataframes

myplot<-function(data,x ,y ){
  pal<-pnw_palette("Lake",3, type = "discrete") # my color palette 
  ggplot(data, aes(x = {{x}}, y = {{y}}, color = island))+    #use curly curly to identify which are columns in the data set
    geom_point()+
    geom_smooth(method = "lm")+ # add a linear model
    scale_color_manual("Island", values=pal)+   # use pretty colors and another example of how to manually change the legend title for colors
    theme_bw()
}

myplot(data = penguins, x = body_mass_g, y = bill_length_mm)
#can put in different ones
myplot(data=penguins, x= body_mass_g, y=flipper_length_mm)

#can make more specific 
# add default to the function
myplot<-function(data = penguins, x, y){
  pal<-pnw_palette("Lake",3, type = "discrete")
  ggplot(data, aes(x = {{x}}, y = {{y}}, color = island))+    #use curly curly to identify which are columns in the data set
    geom_point()+
    geom_smooth(method = "lm")+ # add a linear model
    scale_color_manual("Island", values=pal)+   # use pretty colors and another example of how to manually change the legend title for colors
    theme_bw()
}

myplot(x= body_mass_g, y=flipper_length_mm)
#can layer labs
myplot(x = body_mass_g, y = flipper_length_mm)+
  labs(x = "Body mass (g)",
       y = "Flipper length (mm)")
  

a<-4
b<-5
#Suppose that if a > b then f should be = to 20, else f should be equal to 10. Using if/else we:
      #if and else are own functions
if (a > b) { # my question
  f <- 20 # if it is true give me answer 1
} else { # else give me answer 2
  f <- 10
}
f

#plotting again
myplot<-function(data = penguins, x, y ,lines=TRUE ){ # add new argument for lines
  pal<-pnw_palette("Lake",3, type = "discrete") # my color palette 
  ggplot(data, aes(x = {{x}}, y = {{y}} , color = island))+
    geom_point()+
    geom_smooth(method = "lm")+ # add a linear model
    scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
    theme_bw()
  
#add an if else
  
  myplot<-function(data = penguins, x, y, lines=TRUE ){ # add new argument for lines
    pal<-pnw_palette("Lake",3, type = "discrete") # my color palette 
    if(lines==TRUE){
      ggplot(data, aes(x = {{x}}, y = {{y}} , color = island))+
        geom_point()+
        geom_smooth(method = "lm")+ # add a linear model
        scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
        theme_bw()
    }
    else{
      ggplot(data, aes(x = {{x}}, y = {{y}} , color = island))+
        geom_point()+
        scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
        theme_bw()
    }
  }


  myplot(x = body_mass_g, y = flipper_length_mm)
  myplot(x = body_mass_g, y = flipper_length_mm, lines = FALSE)
