library(RSQLite)
library(data.table)

setwd("C:/Users/popaz/Documents/DataScience/ShinyProject/")

csvpath = "./faers_enigma_2015.csv"
dbname = "./f2015.sqlite"
tblname = "f2015"
## read csv
data <- fread(input = csvpath,
              sep = ",",
              header = TRUE)
## connect to database
conn <- dbConnect(drv = SQLite(), 
                  dbname = dbname)
## write table
dbWriteTable(conn = conn,
             name = tblname,
             value = data)
## list tables
dbListTables(conn)
## disconnect
dbDisconnect(conn)
