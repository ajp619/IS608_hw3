library(shiny)
library(googleVis)

# Set initial state of the graph. String created in the graph with the Advanced Tab
state.var <- '{"sizeOption":"_UNISIZE","yZoomedIn":false,"xLambda":1,"yZoomedDataMin":0,
              "dimensions":{"iconDimensions":["dim0"]},"xZoomedDataMax":52,"xZoomedIn":false,
              "iconType":"VBAR","time":"2010","xAxisOption":"5","showTrails":false,
              "duration":{"timeUnit":"Y","multiplier":1},"uniColorForNonSelected":false,
              "playDuration":15000,"iconKeySettings":[{"key":{"dim0":"National Average"},
              "LabelX":-91,"LabelY":-90},{"key":{"dim0":"California"}},{"key":{"dim0":"New York"},
              "LabelX":-15,"LabelY":-61},{"key":{"dim0":"West Virginia"}}],"orderedByY":false,
              "nonSelectedAlpha":0.4,"xZoomedDataMin":0,"colorOption":"_UNIQUE_COLOR",
              "yAxisOption":"5","orderedByX":true,"yZoomedDataMax":300,"yLambda":1};'

# Define server logic required to plot various variables against mpg
shinyServer(function(input, output) {
  
  # Generate a plot with googleVis
  output$mortalityPlot <- renderGvis({
    gvisMotionChart(mortality.data[mortality.data$ICD.Chapter == input$disease.type,], "State", "Year", 
                    options = list(width = 600, height = 400, state = state.var))
  })
})