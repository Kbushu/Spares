#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Spares Calculator"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("Parts",
                   "Number of parts:",
                   min = 1,
                   max = 1000,
                   value = 20),
       sliderInput("Spares",
                   "Numbers of Spares:",
                   min = 1,
                   max = 120,
                   value = 7),
      sliderInput("Lambda",
                  "Failure Rate/1000Hr:",
                  min = 0.001,
                  max = 100,
                  value = .1),
      
      sliderInput("Time",
                  "Hours Calendar Time:",
                  min = 1,
                  max = 8000,
                  value = 2016)
    ),

    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("partPlot")
    )
  )))
