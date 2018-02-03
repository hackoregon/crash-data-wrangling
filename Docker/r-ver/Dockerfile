FROM rocker/r-ver
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

# pick up "postgres" user's password for the "postgis" service
ARG POSTGRES_PASSWORD

RUN apt-get update \
  && apt-get install -qqy --no-install-recommends \
  mdbtools \
  r-cran-dbi \
  r-cran-hmisc \
  r-cran-rpostgresql \
  && apt-get clean

# create a non-root user
RUN useradd -c "Hack Oregon" -U -m hacko

# Populate /home/hacko
COPY migrate.R /home/hacko
COPY odot_crash_data.mdb /home/hacko/
RUN echo ${POSTGRES_PASSWORD} > /home/hacko/POSTGRES_PASSWORD.txt
RUN chown -R hacko:hacko /home/hacko
USER hacko
WORKDIR /home/hacko/
CMD sleep 30; R --no-save --no-restore < migrate.R 2>&1 | tee migrate.log
