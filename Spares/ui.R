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
      p("1. Start with number of items in use."),
      p("2. How often do you replace it?"),
      p("3. How often do you reorder?"),
      p("4. Adjust spares quantity to achieve desired service level."),
      p("Use the target service level as guideline, then play around."),
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
                  step = 0.001),
      
      sliderInput("Time",
                  "Reorder interval:",
                  min = 0,
                  max = 8760,
                  step = 168,
                  value = 2016),
      p("1 Week  = 168 Hours"),
      p("3 Months  = 2016 Hours"),
      p("1 Year  = 8760 Hours")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      numericInput("Spares",
                   "Adjust spares to meet desired service level:",
                   min = 1,
                   max = 1000,
                   value = 7),
      plotlyOutput("partPlot"),
      sliderInput("bm",
                  "Target Service Level:",
                  min = 0.5,
                  max = 1,
                  value = 0.85,
                  step = 0.05),
      p("Recommended quantity to achieve target service level:"),
      verbatimTextOutput("tgt"),
      p("Calculated Service level:"),
      verbatimTextOutput("Achievedpr")
    )
  )))
