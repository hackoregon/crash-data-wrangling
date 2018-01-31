## Building the image

1. Clone this repository and `cd Serve`.
2. Download the latest version of `odot_crash_data.sql` from Google Drive into this `Serve`.
3. Set the environment variable `POSTGRES_PASSWORD` to a strong password. This will become the password for the `postgres` superuser inside the PostGIS service container.
4. Type `docker-compose build`.

## Starting the network
1. Type `docker-compose up -d`. This will create a network called `serve_default`, then start the service `serve_odot_crash_data_1` in the network.
2. Inside the network, the service is listening on port 5432. To integrate this service into your own Docker compose file, either 
    * copy `docker-compose.yml` from here and add your services to it, or 
    * add the service definition for `odot_crash_data` from this `docker-compose.yml` to yours.

    In either case you will need to have the latest `odot_crash_data.sql` downloaded before doing a build!

3. Port 5432 in the service container is exported to port ***5439*** on the Docker host's `localhost`. You will be able to connect to the database via any host PostgreSQL client as `postgres` using the password you set when you built the image. I use `PgAdmin4` but any client, including Django, should work.
