## Building the image

1. Clone this repository and `cd crash-data-wrangling/Serve`.
2. Download the latest version of `odot_crash_data.sql` from Google Drive into this directory.
3. Set the host environment variable `POSTGRES_PASSWORD` to a strong password. This will become the password for the `postgres` superuser on the image and inside any service containers run from the image.
4. Type `docker-compose build`. This produces an image tagged `docker.io/znmeb/odot_crash_data`. In addition to the PostGIS service, the image contains a copy of the crash database dump `odot_crash_data.sql`.

## Starting the network
1. Type `docker-compose up -d`. This will create a network called `serve_default`, then start the service `serve_odot_crash_data_1` in the network.
2. Inside the network, the service is listening on port 5432. Port 5432 in the service container is exported to port ***5439*** on the Docker host's `localhost`. You will be able to connect to the database via any host PostgreSQL client as `postgres` using the password you set when you built the image. I use `PgAdmin4` but any client, including Django, should work.

## Integrating with other services
There are two ways to integrate this:

1. Run the build step defined above. That gives you a local copy of the image; this image contains a copy of the crash data dump file. Then create a `docker-compose` file that runs the image as a service. It will be listening on port 5432 and will restore the `odot_crash_data` database from the dump file the first time it is started in a container.

2. Create a new directory with your own `docker-compose.yml` file and include the steps for the `odot_crash_data` service from the compose file in this directory. You'll need to 

    * set the `POSTGRES_PASSWORD` host environment variable,
    * copy the crash database dump file, and 
    * copy and rename the Dockerfile in the directory and `docker-compose` file.
