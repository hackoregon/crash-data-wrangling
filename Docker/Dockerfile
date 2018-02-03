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

# pick up "postgres" user's password for the "postgis" service
ARG POSTGRES_PASSWORD

# repo for recent R
COPY R.list /etc/apt/sources.list.d/
RUN apt-key adv --keyserver keys.gnupg.net --recv-key 'E19F5F87128899B192B1A2C2AD5F960A256A04AF'
RUN apt-get update \
  && apt-get install -qqy --no-install-recommends \
  libpq-dev \
  mdbtools \
  r-base \
  r-cran-hmisc \
  r-cran-rpostgresql \
  && apt-get clean

# Populate /home/rstudio
COPY migrate.R /home/postgres
COPY odot_crash_data.mdb /home/postgres/
RUN echo ${POSTGRES_PASSWORD} > /home/postgres/POSTGRES_PASSWORD.txt
RUN chown -R postgres:postgres /home/postgres
