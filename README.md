## Running the migration

1. Clone this repository and `cd` into it.
2. Copy the ODOT crash data file as `odot_crash_data.mdb` into the `r-base` subdirectory.
3. Set the ***host*** environment variable `POSTGRES_PASSWORD` to a strong password. This will become the password for the `postgres` superuser inside the PostGIS service container.
4. Type `docker-compose build`.
5. Type `docker-compose up -d`. Two containers will be created.
6. Type `docker logs -f crashdatawrangling_r-base_1`. You'll see the migration script run. When it's done you'll see

    ```
    pg_dump: creating CONSTRAINT "public.crash crash_pkey"
    pg_dump: creating CONSTRAINT "public.partic partic_pkey"
    pg_dump: creating CONSTRAINT "public.vhcl vhcl_pkey"
    pg_dump: creating ACL "public"
    > 
    ```
7. Type `docker cp crashdatawrangling_r-base_1:/home/hacko/odot_crash_data.sql .` to copy the SQL dump file out of the container where it was created.

Note that the migration process changes all the table and column names to lower case.
