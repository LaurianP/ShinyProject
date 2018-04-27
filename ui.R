library(shiny)
library(shinydashboard)

# we can use CSS to create a different style
shinyUI(dashboardPage(
    dashboardHeader(title = "FDA Adverse Event Data"),
    dashboardSidebar(
      sidebarUserPanel("Marius"),
      sidebarMenu(
        menuItem("By Sex", tabName="bysex", icon=icon("map"))
      )
    ),
    dashboardBody(
      tabItems(
        tabItem(tabName = "bysex", 
          fluidRow(
            column(width=10, offset=1, 
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
            )
          ),
          fluidRow(column(6, plotOutput("bysex")))
        )
      )
    )
  )
)
