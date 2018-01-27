FROM docker.io/rocker/rstudio
MAINTAINER M. Edward (Ed) Borasky <znmeb@znmeb.net>

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
  && apt-get clean

# update the databases
RUN mandb
RUN apt-file update
RUN updatedb

# R packages we need
RUN R --no-save --no-restore -e "install.packages(c('Hmisc', 'RPostgres'))"
