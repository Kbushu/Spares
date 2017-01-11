#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

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
       
      sliderInput("Lambda",
                  "Failure Rate/1000Hr:",
                  min = 0.001,
                  max = 100,
                  value = 0.1,
                  step = 0.1),
      
      sliderInput("Time",
                  "Reorder interval:",
                  min = 1,
                  max = 8000,
                  value = 2016),
      
      h4("Calendar Time"),
      p("1 Week  = 168 Hours"),
      p("3 Months  = 2160 Hours"),
      p("1 Year  = 8760 Hours"),
      
      sliderInput("bm",
                  "Target Service Level:",
                  min = 0.5,
                  max = 1,
                  value = 0.85,
                  step = 0.05),
      
      numericInput("Spares",
                  "Numbers of Spares:",
                  min = 1,
                  max = 120,
                  value = 7)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      h3("Spares Calculation Result"),
      plotlyOutput("partPlot"),
      p("Recommended quantity to achieve target service level:"),
      verbatimTextOutput("tgt"),
      verbatimTextOutput("Achievedpr")
    )
  )))
