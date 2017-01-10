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
    Spares <- ceiling(klt)
    pr <- poisson.test(T = klt, x = Spares, alternative = "less")$p.value
    while(pr < 0.85){
      Spares <- Spares + 1
      pr <- poisson.test(T = klt, x = Spares, alternative = "less")$p.value
    }
    output$tgt <- renderPrint(Spares)
    # draw the plot
    plot(x = klt, 
         y = pr,
         ylab = "Stock Probability %",
         xlab = "Parts Replacements",
         ylim = c(0,1),
         xlim = c(0.01, 100),
         col="blue")
    abline(h = pr, col="red",lwd=5)
    abline(v = klt, col="red",lwd=5)
    text(80, .97, paste("Prob = ", 100*round(pr, 2),"%"))
    text(80, .8, paste("Spares = ", input$Spares))
    text(80, .7, paste("klt = ", round(klt, 2)))

  })
  
})
