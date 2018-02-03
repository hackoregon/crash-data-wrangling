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
    drv = RPostgreSQL::PostgreSQL(),
    dbname = dbname
  ))
}

# connect to destination PostgreSQL server and create a database
pgcon <- get_postgresql_connection("postgres")
dummy <- DBI::dbSendStatement(pgcon, "DROP DATABASE IF EXISTS odot_crash_data;")
DBI::dbClearResult(dummy)
dummy <- DBI::dbSendStatement(pgcon, "CREATE DATABASE odot_crash_data;")
DBI::dbClearResult(dummy)
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

# add geometry column
dummy <- DBI::dbSendStatement(
  pgcon,
  "ALTER TABLE crash ADD COLUMN geom_4269 geometry;"
)
DBI::dbClearResult(dummy)
update <- paste(
  "UPDATE crash",
  "SET geom_4269 = ST_SetSRID(ST_MakePoint(longtd_dd, lat_dd), 4269)",
  "WHERE longtd_dd IS NOT NULL AND lat_dd IS NOT NULL;",
  sep = " "
)
dummy <- DBI::dbSendStatement(pgcon, update)
DBI::dbClearResult(dummy)

# add primary keys
dummy <- DBI::dbSendStatement(
  pgcon,
  "ALTER TABLE public.crash ADD CONSTRAINT crash_pkey PRIMARY KEY (crash_id);"
)
DBI::dbClearResult(dummy)

dummy <- DBI::dbSendStatement(
  pgcon,
  "ALTER TABLE public.partic ADD CONSTRAINT partic_pkey PRIMARY KEY (partic_id);"
)
DBI::dbClearResult(dummy)

dummy <- DBI::dbSendStatement(
  pgcon,
  "ALTER TABLE public.vhcl ADD CONSTRAINT vhcl_pkey PRIMARY KEY (vhcl_id);"
)
DBI::dbClearResult(dummy)

# disconnect
DBI::dbDisconnect(pgcon)

# dump to SQL text
system("pg_dump --verbose --clean --if-exists --dbname=odot_crash_data > odot_crash_data.sql")
