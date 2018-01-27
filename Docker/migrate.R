get_tables <- function(mdb_file) {
  tables <- Hmisc::mdb.get(mdb_file, tables = TRUE)
  return(grep(pattern = "^tbl", x = tables, invert = TRUE, value = TRUE))
}

get_table <- function(mdb_file, table_name) {
  work <- Hmisc::mdb.get(mdb_file, tables = table_name, allow = "_")
  colnames(work) <- tolower(colnames(work))
  return(work)
}

postgresql_connection <- function(service_name, dbname, password) {
  return(DBI::dbConnect(
    drv = RPostgres::Postgres(),
    host = service_name,
    port = 5432,
    user = "postgres",
    dbname = dbname,
    password = password
  ))
}

# connect to destination PostgreSQL server and create a database
conn <- postgresql_connection("postgis", "postgres", postgres_password)
DBI::dbSendStatement(conn, "CREATE DATABASE odot_crash_data;")
DBI::dbDisconnect(conn)

# reconnect to the new database
conn <- postgresql_connection("postgis", "odot_crash_data", postgres_password)

# get list of tables from MDB file
tables <- get_tables("odot_crash_data.mdb")
for (table_name in tables) {
  cat("\nMigrating table", table_name, "\n")
  work <- get_table("odot_crash_data.mdb", table_name)
  DBI::dbWriteTable(conn, tolower(table_name), work, overwrite = TRUE)
}

# disconnect
DBI::dbDisconnect(conn)
