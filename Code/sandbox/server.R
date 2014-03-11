library(shiny)
library(datasets)
library(ggplot2)

# We tweak the "am" field to have nicer factor labels. Since this doesn't
# rely on any user inputswe can do this once at startup and then use the
# value throughout the lifetime of the application
mpgData <- mtcars
mpgData$am <- factor(mpgData$am, labels = c("Automatic", "Manual"))

# Define server logic required to plot various variables against mpg

shinyServer(function(input, output) {
  
  # Compute the formula text in a reactive expression since it is
  # shared by the output$caption and output$mpgPlot expressions
  formulaText <- reactive({
    paste("mpg ~", input$variable)
  })
  
  # Return the formula test for printing as a caption
  output$caption <- renderText({
    formulaText()
  })
  
  output$mpgPlot <- renderPlot({
#     boxplot(as.formula(formulaText()),
#             data = mpgData,
#             outline = input$outliers)
    xvar <- input$variable
    p <- ggplot(data=mpgData, aes_string(x=paste(input$variable), y="mpg")) +
      geom_boxplot()
    print(p)
  })
})