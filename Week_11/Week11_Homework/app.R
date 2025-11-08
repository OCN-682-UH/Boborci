

library(shiny)
library(tidyverse)
library(rsconnect)
library(here)
library(dplyr)
library(ggplot2)
library(bslib)



#coffee<-read.csv(here("Week_11", "Week11_Homework", "Coffe_sales.csv"))-- using the here function was causing my app to not run
coffee<-read.csv("Coffe_sales.csv")

#select coffee name see dist times of purchase



# Define UI for application that draws a density plot
ui <- fluidPage(
  selectInput(inputId= "select_coffee",               #what I want the user to do
              label="Select a Drink",                 #tell them what to do
              choices=unique(coffee$coffee_name),     #define choices for user
              selected="Latte",                       #default choice (because it's my drink of choice)
              multiple=FALSE),                        #only allow one selection because my brain can't handle multiple
  plotOutput("density"),                             #want a density plot cos I've never made one
  h3("Coffee Purchase Information"),
    tableOutput("coffee_table"),                    #Add a table output also
  theme = bs_theme(preset = "flatly"))

      
server <- function(input, output) {                      #behind the scenes part

  data <- reactive({
    req(input$select_coffee)                             #defining data as reactive
    coffee %>%
      filter(coffee_name == input$select_coffee)         #needs to match what I named it above
  })
  output$density <- renderPlot({                         #tell it to make my density plot
    ggplot(data(), aes(x = hour_of_day)) +               #define x axis
      geom_density(fill = "#F792D7", alpha = 0.7) +     #I just like this color
      scale_x_continuous(breaks = c(4,6,8, 10, 12, 14, 16, 18, 20,22,24))+   #want it to show a lot of time on the x axis to make it easier to visualize
      labs(title =paste("Time of Purchase Distribution for", input$select_coffee),  #make title change with coffee choice (ooo fancy)
           x="Hour of Purchase",
           y="Density")                                     #label axes
  })
 
      output$coffee_table <- renderTable({                    # Make da Table
        data() %>%
          select(                                  #make column names what I want
            "Coffee Name" = coffee_name, 
            "Price (unknown unit)" = money, 
            "Time of Day" = Time_of_Day, 
            "Day of the Week" = Weekday)%>%
   head(10)               #lots of vals, just allow 10 to be viewed for ease
  })
  
} 
      
shinyApp(ui = ui, server = server)                          #make da app

      
      
      
      
      
      
      
      
      
      
      