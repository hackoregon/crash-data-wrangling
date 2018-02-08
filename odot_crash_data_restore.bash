#! /bin/bash

set +e # continue on error

dropdb odot_crash_data
createdb odot_crash_data
pg_restore --verbose --dbname=odot_crash_data odot_crash_data.backup
