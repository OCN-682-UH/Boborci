library(shiny)

#ui<-FluidPage()   #sets UI
#server<-fuction(input,output) {}
#shinyApp(ui=ui, server=server)
#save script as app.R

#Inputs are what user decides

ui <- fluidPage(
  #Input functions
  #Output functions
  #typeInput
  sliderInput(inputId="num", #ID name for input
              label="Choose a number", #Label above the input
              value=25,min=1, max =100 #values for slider
  ))
server<-function(input,output){}
shinyApp(ui=ui, server=server)




ui <- fluidPage(
  #Input functions
  #Output functions
  #typeInput
  sliderInput(inputId="num", #ID name for input
              label="Choose a number", #Label above the input
              value=25,min=1, max =100 #values for slider
  ), #need comma between all things in in ui
  plotOutput("hist") #will make a histogram, name will be used below in server, must match
)
server<-function(input,output){
  output$hist<-renderPlot({
    data<-tibble(x=rnorm(100))
    
    ggplot(data, aes(x=x))+
      geom_histogram()
    
  })
}
shinyApp(ui=ui, server=server)





ui <- fluidPage(
  #Input functions
  #Output functions
  #typeInput
  sliderInput(inputId="num", #ID name for input
              label="Choose a number", #Label above the input
              value=25,min=1, max =100 #values for slider
  ), #need comma between all things in in ui
  plotOutput("hist") #will make a histogram, name will be used below in server, must match
)
server<-function(input,output){
  output$hist<-renderPlot({
    data<-tibble(x=rnorm(input$num))  #user picks Input Id, name it same, so user chooses number
    
    ggplot(data, aes(x=x))+
      geom_histogram()
    
  })
}
shinyApp(ui=ui, server=server)
#YA




#Two types of inputs 
ui <- fluidPage(
  #Input functions
  #Output functions
  #typeInput
  sliderInput(inputId="num", #ID name for input
              label="Choose a number", #Label above the input
              value=25,min=1, max =100 #values for slider
  ), #need comma between all things in in ui
  textInput(inputId = "title",
            label="Write a Title",
            value="Histogram of Random Normal Values"),
  plotOutput("hist") #will make a histogram, name will be used below in server, must match
)
server<-function(input,output){
  output$hist<-renderPlot({
    data<-tibble(x=rnorm(input$num))
    
    ggplot(data, aes(x=x))+
      geom_histogram()
    labs(title=input$title)    #again use name from input
    
  })
}
shinyApp(ui=ui, server=server)

#two outputs

ui <- fluidPage(
  sliderInput(inputId="num", #ID name for input
              label="Choose a number", #Label above the input
              value=25,min=1, max =100 #values for slider
  ), #need comma between all things in in ui
  textInput(inputId = "title",
            label="Write a Title",
            value="Histogram of Random Normal Values"),
  plotOutput("hist") #will make a histogram, name will be used below in server, must match
  ,
  verbatimTextOutput("stats"))

server<-function(input,output){
  output$hist<-renderPlot({
    data<-tibble(x=rnorm(input$num))
    
    ggplot(data, aes(x=x))+
      geom_histogram()
    labs(title=input$title)    #again use name from input
    
  })
  output$stats<-renderPrint({
    summary(rnnorm(input$num))
  })
}
shinyApp(ui=ui, server=server)



#want both data sets to be same 
#make a reactive- makes dataset a function of its own
#data<-reactive({rnnorm(input$num)})