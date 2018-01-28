# read password for "postgres" database user
postgres_password <- readLines("POSTGRES_PASSWORD.txt")

# Set environment variables
Sys.setenv(
  PGHOST = "postgis",
  PGPORT = 5432,
  PGUSER = "postgres",
  PGPASSWORD = postgres_password
)

# define functions
get_mdb_tables <- function(mdb_file) {
  tables <- Hmisc::mdb.get(mdb_file, tables = TRUE)
  return(grep(pattern = "^tbl", x = tables, invert = TRUE, value = TRUE))
}

get_mdb_table <- function(mdb_file, table_name) {
  work <- Hmisc::mdb.get(mdb_file, tables = table_name, allow = "_")
  colnames(work) <- tolower(colnames(work))
  return(work)
}

get_postgresql_connection <- function(dbname) {
  return(DBI::dbConnect(
    drv = RPostgres::Postgres(),
    dbname = dbname
  ))
}

# connect to destination PostgreSQL server and create a database
pgcon <- get_postgresql_connection("postgres")
DBI::dbSendStatement(pgcon, "CREATE DATABASE odot_crash_data;")
DBI::dbDisconnect(pgcon)

# reconnect to the new database
pgcon <- get_postgresql_connection("odot_crash_data")

# get list of tables from MDB file
tables <- get_mdb_tables("odot_crash_data.mdb")
for (table_name in tables) {
  cat("\nMigrating table", table_name, "\n")
  work <- get_mdb_table("odot_crash_data.mdb", table_name)
  DBI::dbWriteTable(pgcon, tolower(table_name), work, overwrite = TRUE)
}

# disconnect
DBI::dbDisconnect(pgcon)

# dump to SQL text
system("pg_dump --dbname=odot_crash_data > odot_crash_data.sql")
