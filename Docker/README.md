## Getting started

1. Clone this repository and `cd Docker`.
2. Copy the ODOT crash data file as `odot_crash_data.mdb`.
3. Set the ***host*** environment variable `POSTGRES_PASSWORD` to a strong password. This will become the password for the `postgres` superuser inside the PostGIS service container.
4. Type `docker-compose build`.

## Running the migration
1. Type `docker-compose up -d`.
2. Browse to localhost:7878 and sign in as `rstudio`, password `rstudio`. (Yes, this can be changed.)
3. Open the file `migrate.R` and "source" it. (Yes, this can be automated.)
4. In the `Files` pane, fill in the checkmark next to `odot_crash_data.sql`. Then select `Export` in the `More` dropdown. You'll get a file save dialog. This is the plain-text dump of the `odot_crash_data` database. (Yes, this can be automated too.)

Note that the migration process changes all the table and column names to lower case.
