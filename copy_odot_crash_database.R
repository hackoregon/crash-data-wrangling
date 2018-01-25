library(DBI)
library(magrittr)
access_connection <- dbConnect(odbc::odbc(), "odot_crash_data_access")
postgresql_connection <- dbConnect(odbc::odbc(), "odot_crash_data_postgresql")

# There are some tables in the Access data that look like metadata.
# We don't copy those!
access_tables <- dbListTables(access_connection) %>% 
  grep(pattern = "MSys", value = TRUE, invert = TRUE) %>% 
  grep(pattern = "qry", value = TRUE, invert = TRUE) %>% 
  grep(pattern = "tbl", value = TRUE, invert = TRUE)
print(access_tables)

for (table_name in access_tables) {
  cat("\ncopying table", table_name)
  access_table <- dbReadTable(access_connection, table_name)
  dbWriteTable(postgresql_connection, table_name, access_table, overwrite = TRUE)
}
dbDisconnect(access_connection)
dbDisconnect(postgresql_connection)
