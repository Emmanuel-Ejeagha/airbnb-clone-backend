#!/bin/sh

if [ "$DATABASE" = "postgres" ]
then
    echo "Waiting for PostgreSQL..."

    while ! nc -z $SQL_HOST $SQL_PORT; do
        sleep 0.1
    done

    echo "PostgreSQL started"
fi

# Apply database migrations
python manage.py makemigrations
python manage.py migrate

# Start the Django application
exec "$@"