#!/bin/sh

if [ "$DATABASE" = "postgres" ]
then
    while ! pg_isready -h ${SQL_HOST} -p ${SQL_PORT} > /dev/null 2> /dev/null; do
      echo "$(date) - Waiting for PostgreSQL to start..."
      sleep 0.5
    done

    echo "$(date) - PostgreSQL started"
fi

python manage.py flush --no-input
python manage.py migrate
python manage.py collectstatic --no-input --clear

exec "$@"
