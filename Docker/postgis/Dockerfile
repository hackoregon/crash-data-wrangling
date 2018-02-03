FROM postgres:10
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

# Install PostGIS
RUN apt-get update \
  && apt-get install -qqy --no-install-recommends \
  ca-certificates \
  postgis \
  postgresql-10-postgis-2.4 \
  postgresql-10-postgis-2.4-scripts \
  postgresql-10-postgis-scripts \
  && apt-get clean

# 'postgres' Linux home directory
RUN mkdir -p /home/postgres
RUN usermod --shell /bin/bash --home /home/postgres --move-home postgres

# files in this directory run after the database is initialized and started
RUN mkdir -p /docker-entrypoint-initdb.d/
