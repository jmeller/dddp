#
# This is the server logic of a Shiny web application. 
#

library(shiny)
library(ggplot2)
library(dplyr)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$distPlot <- renderPlot({
    
    # switch data sets based on input data
    switch(input$data_set, 
           "mtcars" = {
             xlab <- "Miles per Gallon"
             plot_data <- data.frame(x = mtcars$mpg)
           },
           "rivers" = {
             xlab <- "Lengths of Major North American Rivers (in miles)"
             plot_data <- data.frame(x = rivers)
           },
           "discoveries" = {
             xlab <- "Yearly Numbers of Important Discoveries"
             plot_data <- data.frame(x = as.numeric(discoveries))
           })
    
    # draw the histogram with the specified number of bins
    plot_data %>% ggplot(aes(x = x)) +
      geom_histogram(aes(y = ..density..), bins = input$bins) + 
      theme_bw() +
      theme(panel.background = element_blank(),
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank()) +
      labs(x = xlab, y = "Frequency") +
      ggtitle(paste("Histogram of ", xlab)) -> plot
    
    # add distributions
    mean <- mean(plot_data$x)
    sd <- sd(plot_data$x)
    n <- nrow(plot_data)
    min <- min(plot_data$x)
    max <- max(plot_data$x)
    
    if(input$dnorm){
      y_norm <- dnorm(plot_data$x, mean, sd)
      plot <- plot + geom_line(aes(x = plot_data$x, y = y_norm),
                               size = 1.4, color = "red")
    }
    if(input$dexp){
      y_exp <- dexp(plot_data$x, rate = 1/mean)
      plot <- plot + geom_line(aes(x = plot_data$x, y = y_exp),
                               size = 1.4, color = "blue")
    }
    if(input$dunif){
      y_unif <- dunif(plot_data$x, min = min, max = max)
      plot <- plot + geom_line(aes(x = plot_data$x, y = y_unif),
                               size = 1.4, color = "green")
    }
    
    plot
  })
  
})
