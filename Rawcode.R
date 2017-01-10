# Using the poisson distribution

# d <- data.frame(Replacements = rep(klt, 10), Spares = as.integer(seq.int(from = 1, to = klt+5, length.out = 10)), Probability = rep(NA,10))

Parts <- 20
Lambda <- .1
Time <- 2160
klt <- Parts*Lambda*Time/1000

Spares <- ceiling(klt)
pr <- poisson.test(T = klt, x = Spares, alternative = "less")$p.value
while(pr < 0.85){
  Spares <- Spares + 1
  pr <- poisson.test(T = klt, x = Spares, alternative = "less")$p.value
}

  pr <- poisson.test(T = klt, x = Spares, alternative = "less")$p.value
}

myPlot <- function(Spares, Parts, Lambda, Time) {
  klt <- Parts*Lambda*Time/1000
  pr <- poisson.test(T = klt, x = Spares, alternative = "less")$p.value
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
  text(80, .8, paste("Spares = ", Spares))
  text(80, .7, paste("klt = ", round(klt, 2)))
}

library(manipulate)
manipulate(myPlot(Spares, Parts, Lambda, Time), 
           Spares = slider(1,120), 
           Parts = slider(1,1000),
           Lambda = slider(0.001, 100),
           Time = slider(1,8000))
