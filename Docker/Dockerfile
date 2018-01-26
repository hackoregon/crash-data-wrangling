FROM docker.io/znmeb/postgis
MAINTAINER M. Edward (Ed) Borasky <znmeb@znmeb.net>

# copy in database dump
RUN mkdir -p /docker-entrypoint-initdb.d/
COPY restore.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/restore.sh
COPY odot_crash_data.sql /
