rowlimit = 200 # limiting queries for debugging purposes

dbConnector = function(session, dbname) {
  require(RSQLite)
  ## setup connection to database
  conn <- dbConnect(drv = SQLite(), 
                    dbname = dbname)
  
  ## disconnect database when session ends
  #session$onSessionEnded(function() {
  #  dbDisconnect(conn)
  #})
  
  ## return connection
  conn
}

dbGetByReportDate = function(conn, tblname, day_start, day_end) {
  query = paste("SELECT * FROM",
                 tblname,
                 "WHERE rept_dt BETWEEN",
                 day_start,
                 "AND",
                 day_end, 
                "LIMIT", as.character(rowlimit))
  print(query)
  as.data.table(dbGetQuery(conn = conn, statement = query))
}

# test the query
conn = dbConnector(0, dbname = "./f2015.sqlite")
t1 = dbGetByReportDate(conn, 'f2015', '2015-01-01', '2016-01-01')

t2 = t1 %>%
  select(sex, outc_cod) %>%
  filter(grepl("HO", outc_cod, fixed=TRUE)) %>%
  group_by(sex) %>%
  summarise(nn = n())


#dbGetByReportDateAndOutcome = function(conn, tblname, day_start, day_end, token) {
#  query = paste("SELECT * FROM", 
#                tblname, 
#                "WHERE outc_cod LIKE '%", token, "%'",
#                "WHERE rept_dt BETWEEN ",
#                day_start,
#                "AND",
#                day_end, 
#                "LIMIT", as.character(rowlimit))
# as.data.table(dbGetQuery(conn = conn, statement = query))  
#}

