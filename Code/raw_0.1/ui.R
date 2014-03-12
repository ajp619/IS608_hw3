library(shiny)

# Define UI for displaying mortality data
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Mortality Data"),
  
  sidebarPanel(
    selectInput("disease.type", "Choose a cause of death", 
                choices = disease.types),
    selectInput("states", "States:",
                states, multiple = TRUE, selected = "National Average")
  ),
  
  mainPanel(
    tabsetPanel(
      tabPanel("Mortality Rate per State",
               htmlOutput("mortalityPerState")),
      tabPanel("Mortality Rate over Time",
               htmlOutput("mortalityOverTime")))
  )
))