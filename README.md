# Importing the ODOT crash data into PostgreSQL

## Required software
1. Windows: 64-bit. Windows 7 or later should work, but I only test on Windows 10 Pro.
2. PostgreSQL 10 and PostGIS 2.4: Use the 64-bit EnterpriseDB installer from <https://www.enterprisedb.com/downloads/postgres-postgresql-downloads#windows>. Make sure you install both PostgreSQL and PostGIS. Earlier versions may not work.
3.  Microsoft Access Database Engine 2016 Redistributable from  <https://www.microsoft.com/en-us/download/details.aspx?id=54920>. Again, you need the 64-bit version.
4. R and library packages `magrittr`, `DBI` and `odbc`.

## Creating the destination PostgreSQL database
1. Open PgAdmin4.
2. Connect to PostgreSQL.
3. Right-click on "Databases" and select "Create". Call the new database "odot_crash_data".
4. Open the ODBC Data Sources 64-bit app.
5. Select the "System DSN" tab.
6. Press the "Add" button. Select the PostgreSQL ODBC Driver(Unicode) driver. Press "Finish". Fill in the form:
    * Data Source = "odot_crash_data_postgresql".
    * Database = "odot_crash_data".
    * Server = "localhost"
    * Port = 5432.
    * Username = "postgres".
    * Password = the password you set for the "postgres" user when you installed PostgreSQL.
7. Press "Test". If the connection is successful, you're done. Otherwise, you probably mistyped something. Once the test passes, press "Save". Leave the app open.

## Creating the source Access file data source name
1. Press the "Add" button. Select the Microsoft Access driver. Press "Finish".
2. Set the Data Source Name to "odot_crash_data_access". Press the "Select" button and browse to the Access database ".mdb" file. Press "OK".
3. Press "OK".
4. Close the app.

## Running the R script
There are a number of ways you can run the R script, including with RStudio. The easiest way is to start the R GUI from the "Start" menu, open the script and run it with the menu. The script is called "copy_odot_crash_database.R".

## Saving the database.
1. Right-click on the "odot_crash_data" database and select "Backup".
2. In the panel that opens up, press the "..." button to the right of the "Filename" field. This will open a browser for you to define a file. Use the "sql" format. Set the file name to "odot_crash_data.sql". Press "Create" to close the dialog. 
3. Select the "Plain" entry in the "Format" drop-down. This sets the output format to a plain-text set of SQL operations to re-create the database.
4. Go to the "Dump qptions" tab. In the "Queries" section, set both "Include CREATE DATABASE statement" and "Include DROP DATABASE statement" to "Yes".
Then press "Backup".
5. When the backup is complete, close PgAdmin4. The resulting file is about 74 megabytes.
