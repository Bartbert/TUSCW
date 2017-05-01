
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("The US Civil War Battle Calculator"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("attackStrength", "Attacking SP's:", min = 0, max = 18, value = 1),
      sliderInput("attackLeaders", "Leader attack ratings:", min = 0, max = 6, value = 0),
      checkboxInput("attackDemoralized", label = "Demoralized", value = FALSE),
      checkboxInput("attackSpecialCard", label = "Special Card", value = FALSE),
      checkboxInput("attackNavalSupport", label = "Attacking Naval Support", value = FALSE),
      br(),
      sliderInput("defenseStrength", "Defending SP's:", min = 0, max = 18, value = 1),
      sliderInput("defenseLeaders", "Leader defense ratings:", min = 0, max = 6, value = 0),
      sliderInput("defenseFortifications", label = "Fortification modifier", min = 0, max = 6, value = 0),
      checkboxInput("defenseMountain", label = "Defending behind mountain", value = FALSE),
      checkboxInput("defenseRiver", label = "Defending behind river", value = FALSE),
      checkboxInput("defenseForaging", label = "Foraging", value = FALSE),
      checkboxInput("defenseNavalSupport", label = "Defending Naval Support", value = FALSE)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("battleOutcome"),
      plotOutput("battleLosses")
    )
  )
))
