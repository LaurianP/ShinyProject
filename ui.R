library(shiny)
library(shinydashboard)


shinyUI(dashboardPage(
    dashboardHeader(title = "FDA Adverse Event Data"),
    dashboardSidebar(
      dateInput(inputId = "reportDateStart", 
                label = "Minimum FDA Report Date", 
                value = "2015-01-01", 
                min = "2015-01-01",
                max = "2018-04-27"),
      dateInput(inputId = "reportDateEnd", 
                label = "Minimum FDA Report Date", 
                value = "2016-01-01", 
                min = "2015-01-01",
                max = "2018-04-27"),
      selectizeInput(inputId = "outcome",
                     label = "Patient Outcome",
                     choices = NULL)
    ),
    dashboardBody(
      fluidRow(
        column(6, plotOutput("bysex"))
      )
    )
  )
)
