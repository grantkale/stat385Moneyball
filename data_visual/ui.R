
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Money Ball: MLB Players vs Weather"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      h3("Data Selection"), # Note the ,
      # Dropdown
      selectInput("active_player", #Choose a player to analyze
                  "Choose a player:", # Label
                  choices = c("Kris Bryant", "Anthony Rizzo", "Ben Zobrist", "Addison Russell", "Jason Heyward")),
      selectInput("active_weather", #Choose a weather attribute to analyze
                   "Weather Attributes:", # Label
                   choices = c("Wind Speed", 'Wind Direction', 'Humidity', 'Temperature', 'Precipitation')), # Default Value
      submitButton("Analyze") # Update data
    ),
    

    # Show a plot of the generated distribution
    mainPanel(
      
      plotOutput("distPlot")
    )
  )
))