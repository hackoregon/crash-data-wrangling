FROM docker.io/rocker/rstudio
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

# pick up "postgres" user's password for the "postgis" service
ARG POSTGRES_PASSWORD

# command line / development conveniences
RUN apt-get update \
  && apt-get install -qqy --no-install-recommends \
  apt-file \
  gnupg \
  man-db \
  mlocate \
  vim-nox \
  && apt-get clean

# PostgreSQL is from the PGDG repo so we need to get libpq-dev from there too!
COPY pgdg.list /etc/apt/sources.list.d/
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-get update \
  && apt-get install -qqy --no-install-recommends \
  mdbtools \
  libpq-dev \
  postgresql-client-10 \
  && apt-get clean

# update the databases
RUN mandb
RUN apt-file update
RUN updatedb

# R packages we need
RUN R --no-save --no-restore -e "install.packages(c('Hmisc', 'RPostgres'), quiet = TRUE)"

# Populate /home/rstudio
COPY migrate.R /home/rstudio
COPY odot_crash_data.mdb /home/rstudio/
RUN echo ${POSTGRES_PASSWORD} > /home/rstudio/POSTGRES_PASSWORD.txt
RUN chown -R rstudio:rstudio /home/rstudio
