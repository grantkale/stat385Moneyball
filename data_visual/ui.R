
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(
  
  basicPage(
    plotOutput("plot1", click = "plot_click"),
    verbatimTextOutput("plot_summary")
  ),

  # Application title
  titlePanel("Money Ball: MLB Players vs Weather"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      h3("Data Selection"), # Note the ,
      # Dropdown
      selectInput("active_player", #Choose a player to analyze
                  "Choose a player:", # Label
                  choices = c("Kris Bryant", 
                              "Anthony Rizzo", 
                              "Ben Zobrist", 
                              "Addison Russell", 
                              "Jason Heyward")),
      
      selectInput("active_stat", #Choose a stat to analyze
                  "Choose a statistic:", # Label
                  choices = c("Batting Average", 
                              "Slugging Percentage", 
                              "Home Runs", 
                              "Strikeouts")),
      
      selectInput("active_weather", #Choose a weather attribute to analyze
                   "Weather Attributes:", # Label
                   choices = c('Humidity',
                               'Wind Direction', 
                               'Temperature')), # Default Value
      
      submitButton("Analyze") # Update data
    ),
    

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
))