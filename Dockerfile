FROM java:jre-alpine

LABEL maintainer=przemek@mobtitude.com

ENV MYSQL_CONNECTOR_VERSION=8.0.15 \
    LIQUIBASE_HOME="/opt/liquibase" \
    LIQUIBASE_VERSION="3.5.5" \
    LIQUIBASE_DRIVER="com.mysql.cj.jdbc.Driver" \
    LIQUIBASE_CLASSPATH="/usr/share/java/mysql.jar" \
    LIQUIBASE_URL="" \
    LIQUIBASE_USERNAME="" \
    LIQUIBASE_PASSWORD="" \
    LIQUIBASE_CHANGELOG="liquibase.xml" \
    LIQUIBASE_CONTEXTS="" \
    LIQUIBASE_OPTS=""

COPY entrypoint.sh /entrypoint.sh
COPY liquibase.sh /usr/local/bin/liquibase

RUN set -x \
    && apk add --no-cache --update --virtual .build-deps \
        openssl \
    && wget -q -O "/tmp/mysql-connector-java-$MYSQL_CONNECTOR_VERSION.tar.gz" "https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-$MYSQL_CONNECTOR_VERSION.tar.gz" \
    && tar -zxf "/tmp/mysql-connector-java-$MYSQL_CONNECTOR_VERSION.tar.gz" -C /tmp \
    && mkdir -p /usr/share/java \
    && mv "/tmp/mysql-connector-java-$MYSQL_CONNECTOR_VERSION/mysql-connector-java-$MYSQL_CONNECTOR_VERSION.jar" /usr/share/java/ \
    && ln -s "/usr/share/java/mysql-connector-java-$MYSQL_CONNECTOR_VERSION.jar" /usr/share/java/mysql.jar \
    && wget -q -O /tmp/liquibase.tar.gz "https://github.com/liquibase/liquibase/releases/download/liquibase-parent-$LIQUIBASE_VERSION/liquibase-$LIQUIBASE_VERSION-bin.tar.gz" \
    && mkdir -p "$LIQUIBASE_HOME" \
    && tar -xzf /tmp/liquibase.tar.gz -C "$LIQUIBASE_HOME" \
    && rm -rf /tmp/* \
    && rm -rf "$LIQUIBASE_HOME/sdk" \
    && chmod +x /entrypoint.sh \
    && apk del --no-cache .build-deps

WORKDIR /liquibase
ENTRYPOINT ["/entrypoint.sh"]