FROM docker.io/znmeb/postgis
MAINTAINER M. Edward (Ed) Borasky <znmeb@znmeb.net>

# copy in database dump
RUN mkdir -p /docker-entrypoint-initdb.d/
COPY odot_crash_data.sql /docker-entrypoint-initdb.d/
