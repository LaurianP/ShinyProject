library(shiny)
library(dplyr)
library(tidyr)
library(ggplot2)

function(input, output, session) {
  
  conn = dbConnector(session, dbname = dbname)

  do_db = reactive(dbGetByReportDate(
    conn = conn,
    tblname = tblname, 
    day_start = input$reportDateStart, 
    day_end = input$reportDateEnd))
  
  observeEvent(input$reportDateEnd, {
    #choices = do_db() %>% select(outc_cod) %>% unique()
    updateSelectizeInput(session, inputId = "outcome", choices=c('HO','OT'))
  })
  
  
  outcomeBySex = reactive({
    do_db() %>%
      select(sex, outc_cod) %>%
      filter(sex=='M'|sex=='F') %>%
      filter(grepl(input$outcome, outc_cod, fixed=TRUE)) %>%
      group_by(sex) %>%
      summarise(nn = n())
  })
  
  
  output$bysex <- renderPlot(
    outcomeBySex() %>% 
      ggplot(aes(x = sex, y = nn)) + geom_bar(stat="identity") +
      ggtitle("Count By Sex")
  )
  
}