library(shiny)
library(googleVis)

# Set initial state of the graph. String created in the graph with the Advanced Tab
# state.var1 <- '{"sizeOption":"_UNISIZE","yZoomedIn":false,"xLambda":1,"yZoomedDataMin":0,
#               "dimensions":{"iconDimensions":["dim0"]},"xZoomedDataMax":52,"xZoomedIn":false,
#               "iconType":"VBAR","time":"2010","xAxisOption":"5","showTrails":false,
#               "duration":{"timeUnit":"Y","multiplier":1},"uniColorForNonSelected":false,
#               "playDuration":15000,"iconKeySettings":[{"key":{"dim0":"National Average"},
#               "LabelX":-91,"LabelY":-90},{"key":{"dim0":"California"}},{"key":{"dim0":"New York"},
#               "LabelX":-15,"LabelY":-61},{"key":{"dim0":"West Virginia"}}],"orderedByY":false,
#               "nonSelectedAlpha":0.4,"xZoomedDataMin":0,"colorOption":"_UNIQUE_COLOR",
#               "yAxisOption":"5","orderedByX":true,"yZoomedDataMax":300,"yLambda":1};'

state.var1 <- '{"xLambda":1,"colorOption":"_UNIQUE_COLOR","nonSelectedAlpha":0.4,"xZoomedDataMax":4,"showTrails":false,"yAxisOption":"5","xZoomedDataMin":0,"yZoomedDataMin":0,"dimensions":{"iconDimensions":["dim0"]},"yZoomedDataMax":7,"xZoomedIn":false,"xAxisOption":"5","duration":{"timeUnit":"Y","multiplier":1},"orderedByY":false,"iconKeySettings":[],"iconType":"VBAR","sizeOption":"_UNISIZE","uniColorForNonSelected":false,"playDuration":15000,"orderedByX":true,"yLambda":1,"time":"2010","yZoomedIn":false};'

# state.var2 <- '{"playDuration":15000,"xZoomedDataMin":915148800000,"yZoomedDataMax":6,
#               "iconType":"LINE","dimensions":{"iconDimensions":["dim0"]},"xAxisOption":"_TIME",
#               "yZoomedDataMin":0,"xZoomedIn":false,"yLambda":1,"time":"2010","orderedByY":false,
#               "iconKeySettings":[{"key":{"dim0":"National Average"}},{"key":{"dim0":"California"}},{"key":{"dim0":"New York"}},{"key":{"dim0":"West Virginia"}}],
#               "duration":{"timeUnit":"Y","multiplier":1},"showTrails":false,"yAxisOption":"5",
#               "orderedByX":false,"xLambda":1,"colorOption":"_UNIQUE_COLOR","sizeOption":"_UNISIZE",
#               "yZoomedIn":false,"uniColorForNonSelected":false,"nonSelectedAlpha":0,"xZoomedDataMax":1262304000000};'

state.var2 <- '{"xLambda":1,"colorOption":"_UNIQUE_COLOR","orderedByX":false,"xZoomedDataMax":1262304000000,"showTrails":false,"sizeOption":"_UNISIZE","orderedByY":false,"yZoomedDataMin":0,"dimensions":{"iconDimensions":["dim0"]},"time":"2010","yAxisOption":"5","iconType":"LINE","duration":{"timeUnit":"Y","multiplier":1},"nonSelectedAlpha":0,"xZoomedDataMin":915148800000,"yLambda":1,"yZoomedDataMax":300,"iconKeySettings":[],"xZoomedIn":false,"uniColorForNonSelected":false,"playDuration":15000,"xAxisOption":"_TIME","yZoomedIn":false};'

# Define server logic required to plot mortality rates
shinyServer(function(input, output) {
  
  # Generate a plot with googleVis
  output$mortalityPerState <- renderGvis({
    rfilter <- mortality.data$ICD.Chapter == input$disease.type & 
               mortality.data$State %in% input$states
    gvisMotionChart(mortality.data[rfilter,], "State", "Year", 
                    options = list(width = 900, height = 600, state = state.var1))
  })
  
  output$mortalityOverTime <- renderGvis({
    rfilter <- mortality.data$ICD.Chapter == input$disease.type & 
      mortality.data$State %in% input$states
    gvisMotionChart(mortality.data[rfilter,], "State", "Year", 
                    options = list(width = 900, height = 600, state = state.var2))
  })
  
})