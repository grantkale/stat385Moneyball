
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggplot2)
load("zobrist_final.rda")
load("bryant_final.rda")
load("rizzo_final.rda")
load("russell_final.rda")
load("heyward_final.rda")

shinyServer(function(input, output) {
  
  playerInput = reactive({ # Reactive
    switch(input$active_player, # Load player set
           "Kris Bryant" = bryant_final,
           "Anthony Rizzo" = rizzo_final,
           "Ben Zobrist" = zobrist_final,
           "Addison Russell" = russell_final,
           "Jason Heyward" = heyward_final)
  })
  
  statInput = reactive({ # Reactive
    switch(input$active_stat, # Load player set
           "Batting Average" = playerInput()$AVG,
           "Slugging Percentage" = playerInput()$SLG,
           "Home Runs" = playerInput()$HR,
           "Strikeouts" = playerInput()$SO)
  })
  
  weatherInput = reactive({ #Reactive
    switch(input$active_weather, #Load weather set
           'Temperature' = playerInput()$Temp,
           'Wind Direction' = playerInput()[, 'Wind Dir'], 
           'Humidity' = playerInput()$Humidity
           ) 
    })
  

  output$plot_summary = renderPrint({
    summary(lm(formula = (statInput() ~ weatherInput())))
    
  })
  
  output$plot1 = renderPlot({
    print(sapply(playerInput(), class))
    print(head(playerInput()))
    print(weatherInput())
    plot(weatherInput(), statInput())
    abline(lm(statInput()~weatherInput(), col="red"))
  })

})

View(bryant_final)
