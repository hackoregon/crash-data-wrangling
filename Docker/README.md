## Getting started

1. Clone this repository and `cd Docker`.
2. Copy the ODOT crash data file as `odot_crash_data.mdb`.
3. Set the environment variable `POSTGRES_PASSWORD` to a strong password. This will become the password for the `postgres` superuser inside the PostGIS service container.
4. Type `docker-compose -f rstudio-postgis.yml build`.

