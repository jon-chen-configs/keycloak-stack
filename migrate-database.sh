#!/bin/sh
export $(grep -v '^#' ../../../compose/conf/.env | xargs)
export $(grep -v '^#' ${ENV_DIR:-swarm-envs}/swarm/keycloak-stack/postgres.env | xargs)

docker run -e PGPASSWORD=${POSTGRES_PASSWORD} \
    --rm \
    --name postgres-client \
    --network shared-services_shared-services \
    --volume "/volume1/docker/backups:/backups" \
    docker-hub.cynicsoft.net/postgres-client:latest \
    /bin/sh -c 'pg_dump -c -h postgres -U postgres keycloak > /backups/data/postgres/keycloak_postgres_backup_manual.dump'

docker run -e PGPASSWORD=${POSTGRES_PASSWORD} \
    --rm \
    --name postgres-client \
    --network keycloak-stack_default \
    --volume "/volume1/docker/backups:/backups" \
    docker-hub.cynicsoft.net/postgres-client:latest \
    /bin/sh -c 'psql -h postgres -U postgres -d keycloak -f /backups/data/postgres/keycloak_postgres_backup_manual.dump'