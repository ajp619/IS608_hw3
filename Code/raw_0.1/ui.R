library(shiny)

# Define UI for displaying mortality data
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Mortality Data"),
  
  sidebarPanel(
    selectInput("disease.type", "Choose a cause of death", 
                choices = disease.types)
  ),
  
  mainPanel(
    htmlOutput("mortalityPlot")
  )
))