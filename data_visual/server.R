
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggplot2)
#We need to load in our data.frames, ask how we can do this.

shinyServer(function(input, output) {
  
  playerInput = reactive({ # Reactive
    switch(input$active_player, # Load player set
           "Kris Bryant" = bryant_player_frame,
           "Anthony Rizzo" = rizzo_player_frame,
           "Ben Zobrist" = zobrist_player_frame,
           "Addison Russell" = russell_player_frame,
           "Jason Heyward" = heyward_player_frame)
  })
  
  weatherInput = reactive({ #Reactive
    switch(input$active_weather, #Load weather set
           'Wind Direction' = win_dir, 
           'Humidity' = humidity,
           'Temperature' = temp) 
    })
  

  output$distPlot <- renderPlot({

    g = ggplot(long_births) +
      geom_line(aes(x = input$active_player, y = input$active_weather, color = hospital))
  })

})

