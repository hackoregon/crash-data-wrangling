# Importing the ODOT crash data into PostgreSQL

## Required software
1. Windows: 64-bit. Windows 7 or later should work, but I only test on Windows 10 Pro.
2. PostgreSQL 10 and PostGIS 2.4: Use the 64-bit EnterpriseDB installer from <https://www.enterprisedb.com/downloads/postgres-postgresql-downloads#windows>. Make sure you install both PostgreSQL and PostGIS. Earlier versions may not work.
3.  Microsoft Access Database Engine 2016 Redistributable from  <https://www.microsoft.com/en-us/download/details.aspx?id=54920>. Again, you need the 64-bit version.

## Creating an ODBC data set name (DSN)
1. Open the ODBC Data Sources 64-bit app.
2. Select the "System DSN" tab.
3. Press the "Add" button. Select the Microsoft Access driver. Press "Finish".
4. Set the Data Source Name to "odot_crash_data_dsn". Press the "Select" button and browse to the Access database ".mdb" file. Press "OK".
5. Press "OK".

## PgAdmin4 operations

### Creating the database
1. Start PgAdmin4 and connect to PostgreSQL as the "postgres" user.
2. Create a database called "odot_crash_data".
3. In the database, create the "ogr_fdw" extension.

### Creating the foreign data server
1. Open the "Foreign Data Wrappers -> ogr_fdw" tree. You'll see "Foreign Servers". Right-click on "Foreign Servers" and select "Create".
2. Set the name to "odot_crash_data_server".
3. On the "Options" tab, press the "+" to add an option row.
4. In the blank row, set the "Options" field to "datasource". Set the "Value" field to "ODBC:odot_crash_data_dsn". Then press "Save".

### Importing the data
1. Right-click on the "odot_crash_data" database and open the Query Tool.
2. Paste the following code in the query editor

    ```
    CREATE SCHEMA IF NOT EXISTS odot_crash_data_schema;
    IMPORT FOREIGN SCHEMA ogr_all 
    FROM SERVER odot_crash_data_server INTO odot_crash_data_schema;
    ```
3. Run the query by pressing the lightning bolt button above the query editor. The import will proceed.
4. When the query finishes, right-click on "Schemas" and refresh. Then go down the tree to "Foreign Tables" and you'll see the imported data!

### Saving the database.
1. Right-click on the "odot_crash_data" database and select "Backup".
2. In the panel that opens up, press the "..." button to the right of the "Filename" field. This will open a browser for you to define a file. Use the "sql" format. Press "Create" to close the dialog. Then press "Backup".
3. When the backup is complete, close PgAdmin4.

## Restoring to another system1. 
