#!/bin/bash
# docker entrypoint script.

# wait until Postgres is ready
while ! pg_isready -q -d $DATABASE_URL
do
  echo "$(date) - waiting for database to start"
  sleep 2
done

bin="/app/bin/one_litre"

# migrate the database
echo "starting Migrations"
eval "$bin eval \"OneLitre.Release.migrate\""

# start the elixir application
echo "starting Application"
exec "$bin" "start"
