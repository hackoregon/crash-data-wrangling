FROM docker.io/znmeb/postgis
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

RUN mkdir -p /docker-entrypoint-initdb.d/
COPY odot_crash_data.sql /docker-entrypoint-initdb.d/
