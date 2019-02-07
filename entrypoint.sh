#!/bin/sh

set -o pipefail
set -o nounset
set -o errexit

LIQUIBASE_OPTS="$LIQUIBASE_OPTS --defaultsFile=/liquibase.properties"

rm -f /liquibase.properties
touch /liquibase.properties

## Database driver
if [ -n "$LIQUIBASE_DRIVER" ]; then
    echo "driver: ${LIQUIBASE_DRIVER}" >> /liquibase.properties
fi

## Classpath
if [ -n "$LIQUIBASE_CLASSPATH" ]; then
    echo "classpath: ${LIQUIBASE_CLASSPATH}" >> /liquibase.properties
fi

## Database url
if [ -n "$LIQUIBASE_URL" ]; then
    echo "url: ${LIQUIBASE_URL}" >> /liquibase.properties
fi

## Database username
if [ -n "$LIQUIBASE_USERNAME" ]; then
    echo "username: ${LIQUIBASE_USERNAME}" >> /liquibase.properties
fi

## Database password
if [ -n "$LIQUIBASE_PASSWORD" ]; then
    echo "password: ${LIQUIBASE_PASSWORD}" >> /liquibase.properties
fi

## Database contexts
if [ -n "$LIQUIBASE_CONTEXTS" ]; then
    echo "contexts: ${LIQUIBASE_CONTEXTS}" >> /liquibase.properties
fi

## Database changelog file
if [ -n "$LIQUIBASE_CHANGELOG" ]; then
    echo "changeLogFile: ${LIQUIBASE_CHANGELOG}" >> /liquibase.properties
fi

TASK=""
if [ $# -gt 0 ]; then
    TASK="$1"
fi

case "$TASK" in
    ## show configuration
    showConf)
        cat /liquibase.properties
        ;;

    ## Default task - execute liquibase
    *)
        # shellcheck disable=SC2086
        /usr/local/bin/liquibase $LIQUIBASE_OPTS "$@"
        ;;
esac