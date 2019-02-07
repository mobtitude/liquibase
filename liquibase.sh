#!/usr/bin/env sh

CP=.

for i in "$LIQUIBASE_HOME"/liquibase*.jar; do
  CP="$CP:$i"
done
CP="$CP:$LIQUIBASE_HOME/lib/"
for i in "$LIQUIBASE_HOME"/lib/*.jar; do
  CP="$CP:$i"
done

# add any JVM options here
JAVA_OPTS="${JAVA_OPTS-}"

# shellcheck disable=SC2086
java -cp "$CP" $JAVA_OPTS liquibase.integration.commandline.Main "$@"
