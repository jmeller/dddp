#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Analysis of distributional assumptions"),
  
  # Description
  h2("Goal"),
  p(paste0("This application visualizes the histograms of variables ", 
           "from different data sets. Moreover, you can visually inspect the fit ",
           "of different standard distributions.")),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      # Select data set
      h3("Parameters"),
      strong("Data set:"),
      p("Please choose the data to visualize among the following three data sets."),
      selectInput("data_set", NULL,
                  c("Motor Trend Car Road Tests" = "mtcars",
                    "Lengths of Major North American Rivers" = "rivers",
                    "Yearly Numbers of Important Discoveries" = "discoveries")
                  
      ),
      # Select number of bins
      strong("Number of bins:"),
      p(paste("Now you can choose the number of bins the data is split up into for",
        "the histogram.")),
      sliderInput("bins",
                  NULL,
                  min = 1,
                  max = 50,
                  value = 30),
      
      strong("Distribution:"),
      p(paste("By checking one of the following distributions, the respective", 
              "distribution will be fitted to the displayed data.")),
      checkboxInput("dnorm", "Normal distribution", FALSE),
      checkboxInput("dexp", "Exponential distribution", FALSE),
      checkboxInput("dunif", "Uniform distribution", FALSE)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h3("Results"),
      p(paste("In this area, the chosen data as well as the chosen density",
              "distributions will be plotted so you can inspect the fit of the",
              "respective distribution to the data.")),
      plotOutput("distPlot")
    )
  )
))
