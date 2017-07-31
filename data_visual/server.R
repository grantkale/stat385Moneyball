
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
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
  

  output$distPlot <- renderPlot({

    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)

    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')

  })

})
