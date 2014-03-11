library(shiny)

# Define UI for miles per gallon application
shinyUI(pageWithSidebar(
  # Application title
  headerPanel("Miles Per Gallon"),
  
  # Sidebar with controls to select the ariable to plot against mpg
  # and to specify whether outliers should be included
  sidebarPanel(
    selectInput("variable", "Variable:",
                list("Cylinders" = "cyl",
                     "Transmission" = "am",
                     "Gears" = "gear")),
    checkboxInput("outliers", "Show Outliers", FALSE)
    ),
  
  mainPanel(
    h3(textOutput("caption")),
    
    plotOutput("mpgPlot")
  )
  
))