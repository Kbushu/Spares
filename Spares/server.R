#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a plot
shinyServer(function(input, output) {
  output$partPlot <- renderPlot({
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
    # draw the plot
    plot(x = klt, 
         y = pr,
         ylab = "Service Level %",
         xlab = "Part Replacements",
         ylim = c(0,1),
         xlim = c(0.01, 100),
         col="blue")
    abline(h = pr, col="red",lwd=5)
    abline(v = klt, col="red",lwd=5)
    text(80, .97, paste("Service = ", 100*round(pr, 2),"%"))
    text(80, .8, paste("Spares = ", input$Spares))
    text(80, .7, paste("Replacements = ", round(klt, 2)))

  })
  
})
