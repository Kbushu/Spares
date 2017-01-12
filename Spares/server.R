#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

# Define server logic required to draw a plot
shinyServer(function(input, output) {
  output$partPlot <- renderPlotly({
    #Calculate outputs from inputs
    klt <- input$Parts*input$Lambda*input$Time/1000
    output$klt = renderPrint(klt)
    pr <- poisson.test(T = klt, x = input$Spares, alternative = "less")$p.value
    output$pr <- renderPrint(pr)
    
    #Set a goal to  recommended a number of spares, 85% as benchmark
    Stock <- ceiling(klt)
    Achievedpr <- poisson.test(T = klt, x = Stock, alternative = "less")$p.value
    while(Achievedpr < input$bm){
      Stock <- Stock + 1
      Achievedpr <- poisson.test(T = klt, x = Stock, alternative = "less")$p.value
    }
    output$Achievedpr <- renderPrint(Achievedpr)
    output$tgt <- renderPrint(Stock)
    #Set benchmark values to show on plot
    a <- list(
      x = klt,
      y = Achievedpr,
      text = "Target",
      xref = "x",
      yref = "y",
      showarrow = TRUE,
      arrowhead = 7,
      ax = 20,
      ay = 10
    )
    # draw the plot
    plot_ly(x = klt, 
         y = pr,
         size = 1,
         type = "scatter",
         mode = "markers") %>%
      layout(title = "Sparing Plot",
             xaxis = list(title = "Replacements"), 
             yaxis = list(title = "Service Level %",
                          range = c(0,1)))  %>%
      layout(annotations = a)
  })
})
